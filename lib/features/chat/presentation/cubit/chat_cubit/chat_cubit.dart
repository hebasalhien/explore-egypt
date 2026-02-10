import 'package:explore_egypt/core/models/chat_model.dart';
import 'package:explore_egypt/core/models/message_model.dart';
import 'package:explore_egypt/core/services/chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatLoading());
  List<MessageModel> _messages = [];
  String? _currentConversationId;
  List<ChatModel> _conversations = [];

  /// sends a message to a new or existing conversation and updates the state accordingly
  Future<void> sendMessage({
    required String message,
    String? conversationId,
  }) async {
    debugPrint('Sending message: $message to conversationId: $conversationId');
    emit(MessageSending(messages: List.from(_messages)));
    try {
      final response = await ChatServices.sendMessage(
        conversationId,
        message: message,
      );
      debugPrint('Message sent successfully: $response');
      if (conversationId == null && response['conversationId'] != null) {
        _currentConversationId = response['conversationId'];
      }
      _messages = (response['messages'] as List)
          .map((msg) => MessageModel.fromJson(msg))
          .toList();
      emit(
        MessageLoaded(
          messages: _messages,
          conversationId: _currentConversationId,
        ),
      );
    } catch (e) {
      debugPrint('Error sending message: $e');
      emit(ChatError(errorMessage: e.toString()));
    }
  }

  /// getter for the current conversation ID, which can be used to continue an existing conversation or start a new one
  String? get currentConversationId => _currentConversationId;

/// fetches all conversations from the server and updates the state accordingly
  Future<void> fetchAllConversations() async {
    emit(ChatLoading());
    try {
      final response = await ChatServices.getConversation();
      debugPrint('all Conversation fetched successfully: $response');
      _conversations = (response as List)
          .map((conversationJson) => ChatModel.fromJson(conversationJson))
          .toList();
      emit(ChatLoaded(conversations: _conversations));
    } catch (e) {
      debugPrint('Error fetching conversation: $e');
      emit(ChatError(errorMessage: e.toString()));
    }
  }
  /// fetches a specific conversation by its ID and updates the state accordingly
  Future<void> fetchConversationById({String? conversationId}) async {
    emit(ChatLoading());
    
    try {
      final response = await ChatServices.getConversation(conversationID: conversationId);
      debugPrint('Conversation fetched successfully: $response');
      _messages = (response['messages'] as List)
          .map((msg) => MessageModel.fromJson(msg))
          .toList();
          _currentConversationId = conversationId;
      emit(
        MessageLoaded(
          messages: _messages,
          conversationId: _currentConversationId,
        ),
      );
    } catch (e) {
      debugPrint('Error fetching conversation: $e');
      emit(ChatError(errorMessage: e.toString()));
    }
  }
}
