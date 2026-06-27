part of 'plan_cubit.dart';

sealed class PlanState {}

final class PlanInitial extends PlanState {}

final class PlanLoading extends PlanState {}

final class NoActivePlan extends PlanState {
  final List<TripModel> plans;
  NoActivePlan({this.plans = const []});
}

final class PlanLoaded extends PlanState {
  final TripModel trip;
  PlanLoaded({required this.trip});
}

final class GetLandmarksSuccess extends PlanState {
  final List<LandmarkModelPlan> landmarks;
  GetLandmarksSuccess({required this.landmarks});
}

final class CreateNewPlan extends PlanState {
  final String title;
  CreateNewPlan({required this.title});
}

final class CreateNewPlanSuccess extends PlanState {
  final TripModel trip;
  CreateNewPlanSuccess({required this.trip});
}

final class GetAllPlansLoading extends PlanState {}

final class GetAllPlansFailure extends PlanState {
  final String error;
  GetAllPlansFailure(this.error);
}

final class GetAllPlansSuccess extends PlanState {
  final List<TripModel> plans;
  GetAllPlansSuccess({required this.plans});
}

final class GetActivePlanFailure extends PlanState {
  final String error;
  GetActivePlanFailure(this.error);
}

final class GetActivePlanSuccess extends PlanState {
  final TripModel activePlan;
  GetActivePlanSuccess({required this.activePlan});
}

final class CreateNewPlanFailure extends PlanState {
  final String error;
  CreateNewPlanFailure(this.error);
}


final class DeletePlaceFromTrip extends PlanState {
  final List<String> placeId;
  final String tripId;
  DeletePlaceFromTrip({required this.placeId, required this.tripId});
}

final class DeletePlaceFromTripSuccess extends PlanState {
  final TripModel trip;
  DeletePlaceFromTripSuccess({required this.trip});
}

final class DeletePlaceFromTripFailure extends PlanState {
  final String error;
  DeletePlaceFromTripFailure(this.error);
}

final class AddNewDayToPlan extends PlanState {}

final class AddNewDaySuccess extends PlanState {
  final TripModel trip;
  AddNewDaySuccess({required this.trip});
}

final class PlanError extends PlanState {}

final class DeleteModeToggled extends PlanState {
  final bool isDeleteMode;
  DeleteModeToggled({required this.isDeleteMode});
}

final class LoadSuggestedPlanLoading extends PlanState {}

final class LoadSuggestedPlanFailure extends PlanState {
  final String error;
  LoadSuggestedPlanFailure(this.error);
}

