import 'package:dio/dio.dart';
import 'package:explore_egypt/models/user_model.dart';
import 'package:explore_egypt/services/api_service.dart';
import 'package:explore_egypt/services/storage_services.dart';

class ProfileService {
  final ApiService _apiService;
  final StorageServices _storageServices;
  ProfileService(this._apiService, this._storageServices);
  Future<dynamic> getUserProfile() async {
    try {
      final response = await _apiService.dio.get('profile');

      final userModel = UserModel.fromjson(response.data);
      await _storageServices.saveUser(userModel);
      return userModel;
    } on DioException   {
      throw Exception('Failed to fetch profile');
    }catch (e) {
      throw Exception(e.toString());
    }
  }
}
