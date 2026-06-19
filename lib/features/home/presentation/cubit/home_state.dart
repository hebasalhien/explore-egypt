part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<LandmarkModel> landmarks;
  final List<PlanCardModel> planCardModel;
 // final ActivePlanModel activePlanModel;
  HomeLoaded({required this.landmarks, required this.planCardModel, 
  //required this.activePlanModel
  });
}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String error;
  HomeError({required this.error});
}
