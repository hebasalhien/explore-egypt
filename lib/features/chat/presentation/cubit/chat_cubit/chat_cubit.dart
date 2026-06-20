import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/chat/model/entities/message_model.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  ChatCubit(this._chatRepository) : super(ChatInitial());
  List<MessageModel> _messages = [];
  String? _currentConversationId;
  CancelToken? _cancelToken;

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
      conversationId: _currentConversationId ,
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
          final trip = TripModel.fromJson(lastMessage);
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
  _messages.removeLast();
        if (e is TimeoutException) { 
    emit(ChatTimeout(messages: _messages, lastMessage: newMessage));
  } else if (e is ServerException) {
    emit(ChatError(errorMessage: e.message.message));
  } else {
    emit(ChatError(errorMessage: e.toString()));
  }
    }
  }

  void cancelGenerating() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel('Request cancelled');
    }
  }

  Future<void> regenerateLastMessage() async{
  emit(MessageSending(messages: List.from(_messages)));
  _cancelToken = CancelToken();
    try{
    final data = await _chatRepository.regenerateLastMessage(conversationId: _currentConversationId!);
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
}
