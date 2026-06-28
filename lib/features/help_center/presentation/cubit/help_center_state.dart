part of 'help_center_cubit.dart';

sealed class HelpCenterState {}

final class HelpCenterInitial extends HelpCenterState {}

final class HelpCenterLoading extends HelpCenterState {}

final class HelpCenterError extends HelpCenterState {
  final String error;
  HelpCenterError({required this.error});
}

final class HelpCenterLoaded extends HelpCenterState {
  final List<FaqModel> faq;
  HelpCenterLoaded({required this.faq});
}