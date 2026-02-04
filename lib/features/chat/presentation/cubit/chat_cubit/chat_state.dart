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

final class MessageSending extends ChatState {}
final class MessageSent extends ChatState {
  final List<MessageModel> messages;
  MessageSent({required this.messages});
}
final class MessageSendError extends ChatState {
  final String errorMessage;

  MessageSendError({required this.errorMessage});
}