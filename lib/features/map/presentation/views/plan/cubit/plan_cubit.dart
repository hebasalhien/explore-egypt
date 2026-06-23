import 'package:explore_egypt/core/constants/storage_constants.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:explore_egypt/features/map/model/entities/landmark_model_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/model/repo/map_repository.dart';
part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  final MapRepository mapRepository;
  PlanCubit(this.mapRepository) : super(PlanInitial());
  List<TripModel>? _cachedPlans; // ← add this field

  Future<void> getAllPlans() async {
    emit(GetAllPlansLoading());

    try {
      _cachedPlans= await mapRepository.getAllMyPlans();

      emit(GetAllPlansSuccess(plans: _cachedPlans!));
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
        _cachedPlans = await mapRepository.getAllMyPlans();
        emit(NoActivePlan(plans: _cachedPlans!));
        return;
      }

      final trip = TripModel.fromJson(response);
      await SharedPrefHelper.setData(StorageConstants.currentPlanId, trip.id);
      emit(GetActivePlanSuccess(activePlan: trip));
    } catch (e) {
      emit(GetActivePlanFailure(e.toString()));
    }
  }

  Future<void> getLandmarkList() async {
    emit(PlanLoading());
    try {
      final response = await mapRepository.getLandmarkList();
      final List<LandmarkModelPlan> landmarks = (response as List)
          .map((e) => LandmarkModelPlan.fromJson(e))
          .toList();
      emit(GetLandmarksSuccess(landmarks: landmarks));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addNewDayToPlan({required TripModel trip}) async {
    emit(PlanLoaded(trip: trip));
    try {
      final response = await mapRepository.addNewDayToPlan(tripId: trip.id!);
      final TripModel updatedTrip = TripModel.fromJson(response);
      emit(AddNewDaySuccess(trip: updatedTrip));
    } catch (e) {
      emit(PlanError());
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

  void displayPlan(TripModel trip) {
    emit(PlanLoaded(trip: trip));
  }

  void goBackToPlans() {
    if (_cachedPlans != null) {
      emit(NoActivePlan(plans: _cachedPlans!));
    }
  }

  Future<String> getCurrentPlanId() async {
    return await SharedPrefHelper.getString(StorageConstants.currentPlanId);
  }

  Future<void> togglePlanActivation({required String newPlanId}) async {
    final currentPlanId = await getCurrentPlanId();
    emit(PlanLoading());
    try {
      if (currentPlanId == newPlanId) {
        await mapRepository.deactivatePlan(currentPlanId: currentPlanId);
        await SharedPrefHelper.removeData(StorageConstants.currentPlanId);
        if(_cachedPlans != null){
          emit(NoActivePlan(plans: _cachedPlans!));
        }else{
          emit(NoActivePlan());
        }
        return;
      }
      final result = await mapRepository.activatePlan(
        newPlanId: newPlanId,
        currentPlanId: currentPlanId,
      );
      final trip = TripModel.fromJson(result);
      await SharedPrefHelper.setData(StorageConstants.currentPlanId, trip.id);
      emit(GetActivePlanSuccess(activePlan: trip));
    } on Exception catch (e) {
      emit(GetActivePlanFailure(e.toString()));
    }
  }
}
