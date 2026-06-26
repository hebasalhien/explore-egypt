part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentLoaded extends CommentState {
  final List<CommentModel> comments;
  CommentLoaded({required this.comments});
}

final class CommentFailure extends CommentState {}
