import 'package:bloc/bloc.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/home/model/repos/home_repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());
  
  /// store plan cards
  List<PlanCardModel> planCards = [];
  /// get plan cards from state to use them in suggested plans page
  List<PlanCardModel> get plans =>
      state is HomeLoaded ? (state as HomeLoaded).planCardModel : [];

  /// get landmarks from state to use them in trending expeditions page
  List<LandmarkModel> get landmarks =>
      state is HomeLoaded ? (state as HomeLoaded).landmarks : [];
  Future<void> getHome() async {
    emit(HomeInitial());
    try {
      final Map<String, dynamic> data = await _homeRepo.getHome();
      final List<LandmarkModel> landmarks = (data['trendingExpeditions'] as List)
          .map((item) => LandmarkModel.fromjson(item))
          .toList();

      planCards = (data['suggestedPlans'] as List)
          .map((plan) => PlanCardModel.fromJson(plan))
          .toList();
      emit(HomeLoaded(landmarks: landmarks, planCardModel: planCards));
    } on ServerException catch (e) {
      emit(HomeError(error: 'faild to load home data due to ${e.message}'));
    } catch (e) {
      emit(HomeError(error: 'faild to load home data due to ${e.toString()}'));
    }
  }
}
