import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class HomeRemoteDataSource {
  final ApiService _apiService = ApiService.instance;

  Future<dynamic> getHome() async {
    final response = await _apiService.dio.get(ApiConstants.home);
    return response.data;
  }


}
