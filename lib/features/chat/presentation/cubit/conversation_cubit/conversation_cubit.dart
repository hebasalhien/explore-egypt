import 'package:explore_egypt/core/models/chat_model.dart';
import 'package:explore_egypt/core/services/chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  ConversationCubit() : super(ConversationInitial());
  List<ChatModel> _conversations = [];


/// fetches all conversations from the server and updates the state accordingly
  Future<void> fetchAllConversations() async {
    emit(ConversationLoading());
    try {
      final response = await ChatServices.getConversation();
      debugPrint('all Conversation fetched successfully: $response');
      _conversations = (response as List)
          .map((conversationJson) => ChatModel.fromJson(conversationJson))
          .toList();
      emit(ConversationLoaded(conversations: _conversations));
    } catch (e) {
      debugPrint('Error fetching conversation: $e');
      emit(ConversationError(errorMessage: e.toString()));
    }
  }
  
}
