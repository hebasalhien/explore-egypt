part of 'suggested_plans_cubit.dart';


sealed class SuggestedPlansState {}

final class SuggestedPlansInitial extends SuggestedPlansState {}

final class SuggestedPlansLoading extends SuggestedPlansState {}

final class SuggestedPlansLoaded extends SuggestedPlansState {
  final List<CategoriesModel> categories;
  final List<PlanCardModel> plans;
  final String selectedCategoryId;
  SuggestedPlansLoaded({required this.categories, required this.plans,required this.selectedCategoryId});
}
final class GetSuggestedPlanSuccessful extends SuggestedPlansState {
final TripModel trip;

GetSuggestedPlanSuccessful({required this.trip});
}

final class SuggestedPlansError extends SuggestedPlansState {
  final String error;
  SuggestedPlansError({required this.error});
}
