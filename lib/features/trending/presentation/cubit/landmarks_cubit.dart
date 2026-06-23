import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/model/repos/home_repository.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:explore_egypt/features/trending/model/repo/landmarks_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'landmarks_state.dart';

class LandmarksCubit extends Cubit<LandmarksState> {
  final List<LandmarkModel> initialLandmarks;
  final HomeRepository _homeRepository;
  final LandmarksRepository _landmarksRepository;
  List<CategoriesModel> categories = [];
  List<LandmarkModel> landmarks = [];
    LandmarksCubit({required this.initialLandmarks, required HomeRepository homeRepository, required LandmarksRepository landmarksRepository})
      : _homeRepository = homeRepository,
      _landmarksRepository = landmarksRepository,
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
  Future<void> getAllFavoriteLandmarks() async {
        try {
      landmarks = (await _landmarksRepository.getFavoriteLandmarks() as List<dynamic>)
          .map((item) => LandmarkModel.fromjson(item))
          .toList();

      emit(
        LandmarksLoaded(
          categories: categories,
          landmarks: landmarks,
          selectedCategoryId: 'Favorite',
        ),
      );
    } catch (e) {
      emit(LandmarksError(error: e.toString()));
    }
  }
  Future<void> getLandmarksByCategory({required String categoryId}) async {
    emit(LandmarksLoading());
    if (categoryId == 'All') {
      landmarks = initialLandmarks;
      emit(
        LandmarksLoaded(
          categories: categories,
          landmarks: landmarks,
          selectedCategoryId: categoryId,
        ),
      );
      return;
    }
    if (categoryId == 'Favorite') {
      await getAllFavoriteLandmarks();
      return;
    }
    try {
      landmarks =
          (await _landmarksRepository.getLandmarksByCategory(categoryId: categoryId)
                  as List<dynamic>)
              .map((item) => LandmarkModel.fromjson(item))
              .toList();

      emit(
        LandmarksLoaded(
          categories: categories,
          landmarks: landmarks,
          selectedCategoryId: categoryId,
        ),
      );
    } catch (e) {
      emit(LandmarksError(error: e.toString()));
    }
  }
}
