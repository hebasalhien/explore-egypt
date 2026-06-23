part of 'landmarks_cubit.dart';

sealed class LandmarksState {}

final class LandmarksInitial extends LandmarksState {}

final class LandmarksLoading extends LandmarksState {}

final class LandmarksLoaded extends LandmarksState {
  final List<CategoriesModel> categories;
  final List<LandmarkModel> landmarks;
  final String selectedCategoryId;
  LandmarksLoaded({required this.categories, required this.landmarks, required this.selectedCategoryId});
}

final class LandmarksError extends LandmarksState {
  final String error;
  LandmarksError({required this.error});
}