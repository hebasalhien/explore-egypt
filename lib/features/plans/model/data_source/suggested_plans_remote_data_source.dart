import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class SuggestedPlansRemoteDataSource {
  final ApiService _apiService;

  SuggestedPlansRemoteDataSource(this._apiService);

  Future<dynamic> getPlansByCategory({required String categoryId}) async {
    final response = await _apiService.dio.get('${ApiConstants.suggestedPlans}/$categoryId');
    return response.data;
  }

  Future<dynamic> getFavoritePlans() async {
    final response = await _apiService.dio.get(ApiConstants.favorite);
    return response.data;
  }

}
