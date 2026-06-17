part of 'plan_cubit.dart';

@immutable
sealed class PlanState {}

final class PlanInitial extends PlanState {}

final class PlanLoading extends PlanState {}

final class NoActivePlan extends PlanState {}

final class PlanLoaded extends PlanState {
  final TripModel trip;
  PlanLoaded({required this.trip});
}

final class CreateNewPlan extends PlanState {}

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

final class AddNewDayToPlan extends PlanState {}

final class AddNewDaySuccess extends PlanState {}

final class PlanError extends PlanState {}

