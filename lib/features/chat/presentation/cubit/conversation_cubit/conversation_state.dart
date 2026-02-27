part of 'conversation_cubit.dart';


@immutable
sealed class ConversationState {}

final class ConversationInitial extends ConversationState {}

final class ConversationLoading extends ConversationState {}

final class ConversationLoaded extends ConversationState {
  final List<ChatModel> conversations;
  ConversationLoaded({required this.conversations});
}

final class ConversationError extends ConversationState {
  final String errorMessage;

  ConversationError({required this.errorMessage});
}


