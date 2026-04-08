import 'package:explore_egypt/features/chat/model/entities/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final ChatRepository _repository;
  ConversationCubit(this._repository) : super(ConversationInitial());
  List<ChatModel> _conversations = [];


/// fetches all conversations from the server and updates the state accordingly
  Future<void> fetchAllConversations() async {
    emit(ConversationLoading());
    try {
      final response = await _repository.getConversation();
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
