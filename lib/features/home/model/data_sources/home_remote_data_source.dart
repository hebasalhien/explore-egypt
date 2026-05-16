import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';

class HomeRemoteDataSource {
  Future<dynamic> getHome() async {
    final response = await ApiService.instance.dio.get(ApiConstants.home);
    return response.data;
  }
}
