part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {}

final class ChatError extends ChatState {
  final String errorMessage;

  ChatError({required this.errorMessage});
}

final class MessageSending extends ChatState 
{
  final List<MessageModel> messages;

  MessageSending({required this.messages});
}

final class MessageLoaded extends ChatState {
  final List<MessageModel> messages;
  final String? conversationId;
  MessageLoaded({this.conversationId,required this.messages});
}
