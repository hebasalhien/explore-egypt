import 'package:dio/dio.dart';
import 'package:explore_egypt/features/chat/model/entities/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final ChatRepository _repository;
  ConversationCubit(this._repository) : super(ConversationInitial());
  List<ChatModel> _conversations = [];
  CancelToken? _cancelToken ;
  /// fetches all conversations from the server and updates the state accordingly
  Future<void> fetchAllConversations() async {
    _cancelToken = CancelToken();
    emit(ConversationLoading());
    try {
      final response = await _repository.getConversation(cancelToken: _cancelToken);
      if(isClosed) return;
      debugPrint('all Conversation fetched successfully');
      _conversations = (response as List)
          .map((conversationJson) => ChatModel.fromJson(conversationJson))
          .toList()
          .reversed
          .toList();
      emit(ConversationLoaded(conversations: _conversations));
    } catch (e) {
      if(isClosed) return;
      debugPrint('Error fetching conversation: $e');
      emit(ConversationError(errorMessage: e.toString()));
    }
  }

    @override
  Future<void> close() {
    _cancelToken?.cancel(); // 👈 cancels the request when drawer closes
    return super.close();
  }

  Future<dynamic> deleteConversation({required String conversationId}) async {
    emit(ConversationLoading());
    try {
      await _repository.deleteConversation(
        conversationId: conversationId,
      );
      _conversations.removeWhere((e) => e.conversationId == conversationId);
      debugPrint('conversation deleted successfully');
      emit(ConversationLoaded(conversations: _conversations));
    } catch (e) {
      debugPrint('Error deleting conversation: $e');
      emit(ConversationError(errorMessage: e.toString()));
    }
  }
}
