import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/features/chat/model/entities/message_model.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  ChatCubit(this._chatRepository) : super(ChatInitial());
  List<MessageModel> _messages = [];
  String? _currentConversationId;

  /// sends a message to a new or existing conversation and updates the state accordingly
  Future<void> sendMessage({
    required String message,
    String? conversationId,
  }) async {
    debugPrint('Sending message: $message to conversationId: $conversationId');
    final newMessage = MessageModel(
      content: message,
      sender: 'user',
      conversationId: _currentConversationId ?? '',
    );
    emit(
      MessageLoaded(
        messages: List.from(_messages..add(newMessage)),
        conversationId: conversationId ?? _currentConversationId,
      ),
    );
    try {
      final data = await _chatRepository.sendMessage(
        conversationId,
        message: message,
      );
      debugPrint('Message sent successfully: $data');
      if (conversationId == null && data['conversationId'] != null) {
        _currentConversationId = data['conversationId'];
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
    } on ServerException catch (e) {
      debugPrint('Error sending message: $e');
      emit(ChatError(errorMessage: e.toString()));
    } catch (e) {
      debugPrint('Error sending message: $e');
      emit(ChatError(errorMessage: e.toString()));
    }
  }

  /// getter for the current conversation ID, which can be used to continue an existing conversation or start a new one
  String? get currentConversationId => _currentConversationId;

  /// fetches a specific conversation by its ID and updates the state accordingly
  Future<void> fetchConversationById({String? conversationId}) async {
    emit(MessageSending(messages: List.from(_messages)));

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
