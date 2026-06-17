part of 'suggested_plans_cubit.dart';

@immutable
sealed class SuggestedPlansState {}

final class SuggestedPlansInitial extends SuggestedPlansState {}

final class SuggestedPlansLoading extends SuggestedPlansState {}

final class SuggestedPlansLoaded extends SuggestedPlansState {
  final List<CategoriesModel> categories;
  final List<PlanCardModel> plans;
  final int selectedIndex;
  SuggestedPlansLoaded({required this.categories, required this.plans,this.selectedIndex = 0});
}

final class SuggestedPlansError extends SuggestedPlansState {
  final String error;
  SuggestedPlansError({required this.error});
}
