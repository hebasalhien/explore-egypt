import 'package:bloc/bloc.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/model/repos/home_repository.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:meta/meta.dart';

part 'landmarks_state.dart';

class LandmarksCubit extends Cubit<LandmarksState> {
  final List<LandmarkModel> initialLandmarks;
  final HomeRepository _homeRepository;
  List<CategoriesModel> categories = [];
  List<LandmarkModel> landmarks = [];
    LandmarksCubit({required this.initialLandmarks, required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(LandmarksLoaded(categories: [], landmarks: initialLandmarks, selectedCategoryId: 'All'));

  Future<void> getCategories() async {
    emit(LandmarksLoading());
    try {
      final response = await _homeRepository.getCategories();
      landmarks = initialLandmarks;
      categories =
          [
            CategoriesModel(name: 'All', id: 'All'),
            CategoriesModel(name: 'Favorite', id: 'Favorite'),
          ] +
          ((response as List<dynamic>)
              .map((item) => CategoriesModel.fromJson(item))
              .toList());
      emit(
        LandmarksLoaded(
          categories: categories,
          landmarks: landmarks,
          selectedCategoryId: "All",
        ),
      );
    } catch (e) {
      emit(LandmarksError(error: e.toString()));
    }
  }
}
