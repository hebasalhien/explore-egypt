import 'package:explore_egypt/core/constants/storage_constants.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/model/repo/map_repository.dart';
part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  final MapRepository mapRepository;
  PlanCubit(this.mapRepository) : super(PlanInitial());
  Future<void> getAllPlans() async {
    emit(GetAllPlansLoading());

    try {
      final List<TripModel> plans = await mapRepository.getAllMyPlans();

      emit(GetAllPlansSuccess(plans: plans));
    } on Exception catch (e) {
      emit(GetAllPlansFailure(e.toString()));
    }
  }

  Future<void> getActivePlan() async {
    emit(PlanLoading());
    try {
      final response = await mapRepository.getActivePlan();

      // empty array = no active plan
      if (response is Map && response.isEmpty) {
        final plans = await mapRepository.getAllMyPlans();
        emit(NoActivePlan(plans: plans));
        return;
      }

      final trip = TripModel.fromJson(response);
      await SharedPrefHelper.setData(StorageConstants.currentPlanId, trip.id);
      emit(GetActivePlanSuccess(activePlan: trip));
    } catch (e) {
      emit(GetActivePlanFailure(e.toString()));
    }
  }

  Future<void> deletePlan({required String tripId}) async {
    emit(GetAllPlansLoading());

    try {
      await mapRepository.deletePlan(tripId: tripId);
    } on Exception catch (e) {
      emit(GetAllPlansFailure(e.toString()));
    }
  }

  void selectActivePlan(TripModel trip) {
    emit(GetActivePlanSuccess(activePlan: trip));
  }
Future<String> getCurrentPlanId() async {
  return await SharedPrefHelper.getString(StorageConstants.currentPlanId);
}
  Future<void> activatePlan({
    required String newPlanId,
  }) async {
    final currentPlanId = await getCurrentPlanId();
    emit(PlanLoading());
    try {
      final result = await mapRepository.activatePlan(
        newPlanId: newPlanId,
        currentPlanId: currentPlanId,
      );
      final trip = TripModel.fromJson(result);
      emit(GetActivePlanSuccess(activePlan: trip));
    } on Exception catch (e) {
      emit(GetActivePlanFailure(e.toString()));
    }
  }
}
