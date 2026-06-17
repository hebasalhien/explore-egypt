import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/model/repo/map_repository.dart';
import 'package:meta/meta.dart';
part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  final MapRepository mapRepository;
  PlanCubit(this.mapRepository) : super(PlanInitial());
  Future<void> getAllPlans() async {
    emit(GetAllPlansLoading());

    try {
      final result = await mapRepository.getAllMyPlans();
      final List<TripModel> plans = (result as List)
          .map((x) => TripModel.fromJson(x))
          .toList();
      emit(GetAllPlansSuccess(plans: plans));
    } on Exception catch (e) {
      emit(GetAllPlansFailure(e.toString()));
    }
  }

  Future<void> deletePlan({required String tripId}) async {
    emit(GetAllPlansLoading());

    try {
      final result = await mapRepository.deletePlan(tripId: tripId);
      final List<TripModel> plans = getAllPlans() as List<TripModel>;
      plans.removeWhere((element) => element.id == tripId);
      emit(GetAllPlansSuccess(plans: plans));
    } on Exception catch (e) {
      emit(GetAllPlansFailure(e.toString()));
    }
  }
}
