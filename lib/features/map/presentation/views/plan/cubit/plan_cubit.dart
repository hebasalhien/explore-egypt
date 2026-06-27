import 'package:explore_egypt/core/constants/storage_constants.dart';
import 'package:explore_egypt/core/local_db/hive_service.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:explore_egypt/features/map/model/entities/landmark_model_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/model/repo/map_repository.dart';
import 'package:explore_egypt/features/plans/model/repo/suggested_plans_repo.dart';
part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  final MapRepository mapRepository;
  final SuggestedPlansRepo suggestedPlansRepo;
  PlanCubit(this.mapRepository, this.suggestedPlansRepo) : super(PlanInitial());
  List<TripModel>? _cachedPlans;
  TripModel? _activePlan;
  TripModel? currentTrip;
  List<String> landmarksList = [];
  bool isDeleteMode = false;
  Set<String> userPlansId = {};
  int totalLandmarks = 0;

  Future<void> getAllPlans() async {
    emit(GetAllPlansLoading());

    try {
      _cachedPlans = await mapRepository.getAllMyPlans();
      if (_cachedPlans != null) {
        for (var trip in _cachedPlans!) {
          userPlansId.add(trip.id!);
        }
      }
      emit(GetAllPlansSuccess(plans: _cachedPlans!));
    } on Exception catch (e) {
      emit(GetAllPlansFailure(e.toString()));
    }
  }

  Future<void> getActivePlan() async {
    // 1️⃣ load from hive first for instant display
    final localTrip = await HiveService().getActiveTrip();
    if (localTrip != null) {
      _activePlan = localTrip.toTripModel();
      currentTrip = _activePlan;
      emit(GetActivePlanSuccess(activePlan: _activePlan!));
    } else {
      emit(PlanLoading());
    }
    try {
      final response = await mapRepository.getActivePlan();
      // empty array = no active plan
      if (response is Map && response.isEmpty) {
        _cachedPlans = await mapRepository.getAllMyPlans();
        if (_cachedPlans != null && _cachedPlans!.isNotEmpty) {
          for (var trip in _cachedPlans!) {
            userPlansId.add(trip.id!);
          }
        }
        emit(NoActivePlan(plans: _cachedPlans!));
        return;
      }

      final trip = TripModel.fromJson(response);
      await SharedPrefHelper.setData(StorageConstants.currentPlanId, trip.id);
      await HiveService().saveActiveTrip(trip.toHive());
      _activePlan = trip;
      currentTrip = trip;
      emit(GetActivePlanSuccess(activePlan: trip));
    } catch (e) {
      if (localTrip != null) {
        emit(GetActivePlanSuccess(activePlan: _activePlan!));
      } else {
        emit(GetActivePlanFailure(e.toString()));
      }
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
      if (userPlansId.contains(tripId)) {
        userPlansId.remove(tripId);
      }
      _cachedPlans = await mapRepository.getAllMyPlans();
      if (_cachedPlans != null && _cachedPlans!.isNotEmpty) {
        for (var trip in _cachedPlans!) {
          userPlansId.add(trip.id!);
        }
      }
      if (_cachedPlans == null || _cachedPlans!.isEmpty) {
        emit(NoActivePlan());
      }
    } on Exception catch (e) {
      emit(GetAllPlansFailure(e.toString()));
    }
  }

  void displayPlan(TripModel trip) {
    currentTrip = trip;
    emit(PlanLoaded(trip: trip));
  }

  void goBackToPlans() {
    if (_activePlan != null) {
      emit(GetActivePlanSuccess(activePlan: _activePlan!));
      return;
    }

    emit(NoActivePlan(plans: _cachedPlans ?? []));
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
        await HiveService().deleteActiveTrip();
        _activePlan = null;
        if (_cachedPlans != null) {
          emit(NoActivePlan(plans: _cachedPlans!));
        } else {
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
      await HiveService().saveActiveTrip(trip.toHive());
      _activePlan = trip;
      currentTrip = trip;
      emit(GetActivePlanSuccess(activePlan: trip));
    } on Exception catch (e) {
      emit(GetActivePlanFailure(e.toString()));
    }
  }

  Future<void> savePlan({required TripModel trip}) async {
    if (trip.id == null || !userPlansId.contains(trip.id)) {
      try {
        final result = await mapRepository.savePlan(trip: trip);
        final TripModel updatedTrip = TripModel.fromJson(result);
        if (updatedTrip.id != null) {
          userPlansId.add(updatedTrip.id!);
        }
        emit(PlanLoaded(trip: updatedTrip));
      } catch (e) {
        emit(PlanError());
      }
    }
  }

  Future<void> loadAndSaveSuggestedPlan({required String planId}) async {
    emit(LoadSuggestedPlanLoading());
    try {
      final response = await suggestedPlansRepo.getPlanDetails(planId: planId);
      final trip = TripModel.fromJson(response);
      final result = await mapRepository.savePlan(trip: trip);
      final TripModel updatedTrip = TripModel.fromJson(result);
      if (updatedTrip.id != null) {
        userPlansId.add(updatedTrip.id!);
      }
      if (_cachedPlans != null) {
        if (!_cachedPlans!.any((element) => element.id == updatedTrip.id)) {
          _cachedPlans!.add(updatedTrip);
        }
      } else {
        _cachedPlans = [updatedTrip];
      }
      currentTrip = updatedTrip;
      emit(PlanLoaded(trip: updatedTrip));
    } catch (e) {
      emit(LoadSuggestedPlanFailure(e.toString()));
    }
  }

  void toggleLandmarkToList({required String landmarkId}) {
    if (landmarksList.any((element) => element == landmarkId)) {
      landmarksList.removeWhere((element) => element == landmarkId);
      totalLandmarks--;
    } else {
      landmarksList.add(landmarkId);
      totalLandmarks++;
    }
  }

  Future<void> addPlaceToDay({
    required int day,
    required String? planId,
  }) async {
    emit(PlanLoading());
    if (landmarksList.isEmpty) {
      return;
    }
    if (planId == null) {
      return;
    }
    try {
      final response = await mapRepository.addPlaceToDay(
        day: day,
        landmarkIds: landmarksList,
        planId: planId,
      );
      landmarksList = [];
      final TripModel updatedTrip = TripModel.fromJson(response);
      emit(PlanLoaded(trip: updatedTrip));
    } catch (e) {
      landmarksList = [];
      emit(PlanError());
    }
  }

  void toggleDeleteMode() {
    isDeleteMode = !isDeleteMode;
    emit(DeleteModeToggled(isDeleteMode: isDeleteMode));
  }

  Future<void> deletePlaceFromDay({
    required int day,
    required String? planId,
  }) async {
    if (landmarksList.isEmpty || planId == null) {
      return;
    }
    emit(PlanLoading());
    try {
      final response = await mapRepository.deletePlaceFromDay(
        day: day,
        landmarkIds: landmarksList,
        planId: planId,
      );
      landmarksList = [];
      totalLandmarks = 0;
      final TripModel updatedTrip = TripModel.fromJson(response);
      emit(PlanLoaded(trip: updatedTrip));
    } catch (e) {
      landmarksList = [];
      totalLandmarks = 0;
      emit(PlanError());
    }
  }
}
