import 'package:explore_egypt/core/models/message_model.dart';
import 'package:explore_egypt/core/services/chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatLoading());

  Future<void> sendMessage({
    required String message,
    String? conversationId,
  }) async {
    debugPrint('Sending message: $message to conversationId: $conversationId');
    emit(MessageSending());
    try {
      List<MessageModel> messages = [];
      final response = await ChatServices().sendMessage(
        conversationId,
        message: message,
      );
      debugPrint('Message sent successfully: $response');
      messages = (response['messages'] as List).map((msg) => MessageModel.fromJson(msg)).toList();
      emit(MessageSent(messages: messages));
    } catch (e) {
      debugPrint('Error sending message: $e');
      emit(MessageSendError(errorMessage: e.toString()));
    }
  }
}
