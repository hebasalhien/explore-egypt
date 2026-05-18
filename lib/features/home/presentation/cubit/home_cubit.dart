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
  Future<void> getHome() async {
    emit(HomeInitial());
    try {
      final Map<String, dynamic> data = await _homeRepo.getHome();

      List<LandmarkModel> landmarks = (data['trendingExpeditions'] as List)
          .map((item) => LandmarkModel.fromjson(item))
          .toList();

      List<PlanCardModel> planCards = (data['suggestedPlans'] as List)
            .map((plan) => PlanCardModel.fromJson(plan))
          .toList();
      emit(HomeLoaded(landmarks: landmarks, planCardModel: planCards));
    } on ServerException catch (e) {
      emit(HomeError());
    } catch (e) {
      emit(HomeError());
    }
  }
}
