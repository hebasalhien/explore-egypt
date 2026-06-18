import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class HomeRemoteDataSource {
  final ApiService _apiService;

  HomeRemoteDataSource(this._apiService);

  Future<dynamic> getHome() async {
    final response = await _apiService.dio.get(ApiConstants.home);
    return response.data;
  }

  Future<dynamic> getCategories() async {
    
    final response = await _apiService.dio.get(ApiConstants.categories);
    return response.data;
  }
}
