part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {
  final UserModel userModel;

  ChatInitial({required this.userModel});
}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {}

final class ChatError extends ChatState {
  final String errorMessage;

  ChatError({required this.errorMessage});
}
