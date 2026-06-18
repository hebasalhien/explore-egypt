import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class LandmarksRemoteDataSource {
  final ApiService _apiService ;

  LandmarksRemoteDataSource(this._apiService) ;

  Future<dynamic> getLandmarksByCategory({required String categoryId}) async {
    final response = await _apiService.dio.get('${ApiConstants.suggestedPlans}/$categoryId');
    return response.data;
  }

  Future<dynamic> getFavoriteLandmarks() async {
    final response = await _apiService.dio.get(ApiConstants.favoriteLandmarks);
    return response.data;
  }

}