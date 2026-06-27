import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/chat/model/entities/message_model.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pcm_sound/flutter_pcm_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  final AudioRecorder _recorder = AudioRecorder();
  final AudioRecorder _callRecorder = AudioRecorder();
  StreamSubscription? _audioSubscription;
  ChatCubit(this._chatRepository) : super(ChatInitial());
  List<MessageModel> _messages = [];
  String? _currentConversationId;
  CancelToken? _cancelToken;
  Timer? _aiSpeakingTimer;
  bool _aiSpeaking = false;

  /// sends a message to a new or existing conversation and updates the state accordingly
  Future<void> sendMessage({
    String? message,
    String? conversationId,
    List<String>? filePath,
    String? mode,
  }) async {
    debugPrint('Sending message: $message to conversationId: $conversationId');
    final newMessage = MessageModel(
      content: message,
      sender: 'user',
      conversationId: _currentConversationId,
      localPaths: filePath ?? [],
      files: [],
    );

    emit(MessageSending(messages: List.from(_messages..add(newMessage))));
    _cancelToken = CancelToken();
    try {
      debugPrint('File paths: $filePath');

      final data = await _chatRepository.sendMessage(
        conversationId,
        message: message,
        filePath: filePath,
        cancelToken: _cancelToken,
        mode: mode,
      );
      debugPrint('Message sent successfully: $data');
      if (conversationId == null && data['conversationId'] != null) {
        _currentConversationId = data['conversationId'];
      }
      if (mode == 'plan') {
        int messageLength = data['messages'].length;
        final lastMessage = data['messages'][messageLength - 1];
        if (lastMessage['type'] == 'plan' && lastMessage['data'] != null) {
          final trip = TripModel.fromJson(
            lastMessage,
          ).copyWith(conversationId: _currentConversationId);
          emit(PlanGeneratied(trip: trip));
        }
      }
      _messages = (data['messages'] as List)
          .map((msg) => MessageModel.fromJson(msg))
          .toList();
      emit(
        MessageLoaded(
          messages: _messages,
          conversationId: _currentConversationId,
        ),
      );
    } catch (e) {
      emit(MessageLoaded(messages: _messages));
      if (e is DioException) {
        final result = ExceptionHandleHelper.handleDioException(e);
        if (result.type == DioExceptionType2.cancelled) {
          emit(MessageLoaded(messages: _messages));
          return;
        } else if (result.type == DioExceptionType2.timeout) {
          emit(ChatTimeout(messages: _messages, lastMessage: _messages.last));
        } else {
          emit(ChatError(errorMessage: result.message));
        }
      } else {
        emit(ChatError(errorMessage: e.toString()));
      }
    }
  }

  /// make the model stop generating
  Future<void> stopGenerating() async {
    emit(MessageSending(messages: _messages));
    try {
      await _chatRepository.stopGenerating(
        conversationId: _currentConversationId!,
      );
      _cancelToken!.cancel();
      emit(
        MessageLoaded(
          messages: _messages,
          conversationId: _currentConversationId,
        ),
      );
    } catch (e) {
      emit(MessageLoaded(messages: _messages));
      if (e is DioException) {
        final result = ExceptionHandleHelper.handleDioException(e);
        if (result.type == DioExceptionType2.cancelled) {
          emit(MessageLoaded(messages: _messages));
          return;
        } else if (result.type == DioExceptionType2.timeout) {
          emit(ChatTimeout(messages: _messages, lastMessage: _messages.last));
        } else {
          emit(ChatError(errorMessage: result.message));
        }
      } else {
        emit(ChatError(errorMessage: e.toString()));
      }
    }
  }

  /// regenerate the model last reply
  Future<void> regenerateLastMessage() async {
    emit(MessageSending(messages: List.from(_messages)));
    _cancelToken = CancelToken();
    try {
      final data = await _chatRepository.regenerateLastMessage(
        conversationId: _currentConversationId!,
      );
      _messages = (data['messages'] as List)
          .map((msg) => MessageModel.fromJson(msg))
          .toList();
      emit(
        MessageLoaded(
          messages: _messages,
          conversationId: _currentConversationId,
        ),
      );
    } catch (e) {
      emit(MessageLoaded(messages: _messages));
      if (e is DioException) {
        final result = ExceptionHandleHelper.handleDioException(e);

        if (result.type == DioExceptionType2.timeout) {
          emit(ChatTimeout(messages: _messages, lastMessage: _messages.last));
        } else {
          emit(ChatError(errorMessage: result.message));
        }
      } else {
        emit(ChatError(errorMessage: e.toString()));
      }
    }
  }

  /// getter for the current conversation ID, which can be used to continue an existing conversation or start a new one
  String? get currentConversationId => _currentConversationId;

  /// fetches a specific conversation by its ID and updates the state accordingly
  Future<void> fetchConversationById({String? conversationId}) async {
    emit(MessageLoading());

    try {
      final data = await _chatRepository.getConversation(
        conversationID: conversationId,
      );
      debugPrint('Conversation fetched successfully: $data');
      _messages = (data['messages'] as List)
          .map((msg) => MessageModel.fromJson(msg))
          .toList();
      _currentConversationId = conversationId;
      emit(
        MessageLoaded(
          messages: _messages,
          conversationId: _currentConversationId,
        ),
      );
    } on ServerException catch (e) {
      debugPrint('Error fetching conversation: $e');
      emit(ChatError(errorMessage: e.toString()));
    } catch (e) {
      debugPrint('Error fetching conversation: $e');
      emit(ChatError(errorMessage: e.toString()));
    }
  }

  /// resets the current conversation and messages, allowing the user to start a new conversation
  void startNewConversation() {
    _currentConversationId = null;
    _messages = [];
    emit(
      MessageLoaded(
        messages: _messages,
        conversationId: _currentConversationId,
      ),
    );
  }

  /// start a live call with the model
  StreamSubscription<List<int>>?
  _micSubscription; // FIX: add this field to your cubit

  /// start a live call with the model
  Future<void> startVoiceCall() async {
    debugPrint('[VoiceCall] 🚀 startVoiceCall called');

    await FlutterPcmSound.setup(sampleRate: 16000, channelCount: 1);
    await FlutterPcmSound.setFeedThreshold(512);
    debugPrint('[VoiceCall] 🎧 PCM player ready');

    FlutterPcmSound.onFeedSamplesCallback = null;
    // FIX: connect first so the controller is recreated before we listen
    try {
      await _chatRepository.connectVoiceCall();
    } catch (e) {
      debugPrint('[VoiceCall] ❌ Connection failed: $e');
      emit(ChatError(errorMessage: 'Voice call connection failed: $e'));
      return;
    }

    _audioSubscription = _chatRepository.getIncomingAudioStream().listen(
      (audioBytes) {
        _aiSpeaking = true; // AI is speaking
        final samples = PcmArrayInt16.fromList(
          audioBytes.buffer.asInt16List().toList(),
        );
        FlutterPcmSound.feed(samples);
        debugPrint(
          '[VoiceCall] 🔊 Fed ${audioBytes.length ~/ 2} samples directly to PCM',
        );

        // Clear flag after a short delay — if no new audio arrives, AI is done
        _aiSpeakingTimer?.cancel();
        _aiSpeakingTimer = Timer(const Duration(milliseconds: 300), () {
          _aiSpeaking = false;
          debugPrint('[VoiceCall] 🎤 AI done speaking — mic re-enabled');
        });
      },
      onError: (e) => debugPrint('[VoiceCall] ❌ Audio stream error: $e'),
      onDone: () {
        _aiSpeaking = false;
        debugPrint('[VoiceCall] 🔌 Audio stream done');
      },
    );

    debugPrint('[VoiceCall] 🎙️ Starting microphone stream...');

    // Check permission before starting
    final hasPermission = await _callRecorder.hasPermission();
    debugPrint('[VoiceCall] 🎙️ Mic permission: $hasPermission');

    if (!hasPermission) {
      debugPrint('[VoiceCall] ❌ No mic permission — aborting');
      emit(ChatError(errorMessage: 'Microphone permission denied'));
      return;
    }

    final micStream = await _callRecorder.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 16000,
        numChannels: 1,
      ),
    );

    _micSubscription = micStream.listen((chunk) {
      // VAD: calculate RMS energy, skip silent chunks
      if (_aiSpeaking) return;
      if (_isSilent(chunk)) return;
      debugPrint('[VoiceCall] 📤 Sending audio chunk: ${chunk.length} bytes');
      _chatRepository.sendAudioChunk(Uint8List.fromList(chunk));
    });

    debugPrint('[VoiceCall] ✅ Voice call fully started');
  }

  /// end a live call with the model
  Future<void> endVoiceCall() async {
    // FIX: cancel mic subscription and stop recorder — was leaking before
    await _micSubscription?.cancel();
    _micSubscription = null;
    await _callRecorder.stop();
    _aiSpeakingTimer?.cancel();
    _aiSpeakingTimer = null;
    _aiSpeaking = false;
    await _audioSubscription?.cancel();
    _audioSubscription = null;
    FlutterPcmSound.onFeedSamplesCallback = null;
    await FlutterPcmSound.release();
    _chatRepository.endVoiceCall();
    debugPrint('[VoiceCall] 📵 Voice call ended');
  }

  bool get isCallActive => _audioSubscription != null;

  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      final dir = await getTemporaryDirectory();
      final path =
          '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(const RecordConfig(), path: path);
      emit(MessageLoaded(messages: _messages));
    }
  }

  Future<void> stopRecording() async {
    final path = await _recorder.stop();
    emit(MessageLoaded(messages: _messages));
    if (path != null) {
      await sendMessage(
        conversationId: currentConversationId,
        filePath: [path],
      );
    }
  }

  bool _isSilent(List<int> chunk) {
    if (chunk.length < 2) return true;

    // Interpret bytes as int16 samples and compute RMS
    double sum = 0;
    for (int i = 0; i < chunk.length - 1; i += 2) {
      final sample = (chunk[i + 1] << 8) | chunk[i]; // little-endian int16
      final signed = sample > 32767 ? sample - 65536 : sample;
      sum += signed * signed;
    }
    final rms = sqrt(sum / (chunk.length / 2));

    // Tune this threshold: 300-500 is typically good for speech vs silence
    return rms < 400;
  }
}
