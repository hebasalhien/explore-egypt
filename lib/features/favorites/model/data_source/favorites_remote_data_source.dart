import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class FavoritesRemoteDataSource {
  final ApiService _apiService;
  FavoritesRemoteDataSource(this._apiService);

  Future<dynamic> getFavoritePlans() async {
    final response = await _apiService.dio.get(ApiConstants.favorite);
    return response.data;
  }

  Future<dynamic> addPlanToFavorites({required String planId}) async {
    final response = await _apiService.dio.post(
      '${ApiConstants.favorite}/$planId',
    );
    return response.data;
  }

  Future<dynamic> removePlanFromFavorites({required String planId}) async {
    final response = await _apiService.dio.delete(
      '${ApiConstants.favorite}/$planId',
    );
    return response.data;
  }

  Future<dynamic> getFavoriteLandmarks() async {
    final response = await _apiService.dio.get(ApiConstants.favoriteLandmarks);
    return response.data;
  }

  Future<dynamic> addLandmarkToFavorites({required String landmarkId}) async {
    final response = await _apiService.dio.post(
      '${ApiConstants.favoriteLandmarks}/$landmarkId',
    );
    return response.data;
  }

  Future<dynamic> removeLandmarkFromFavorites({required String landmarkId}) async {
    final response = await _apiService.dio.delete(
      '${ApiConstants.favoriteLandmarks}/$landmarkId',
    );
    return response.data;
  }
}
