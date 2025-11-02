import 'package:explore_egypt/services/api_service.dart';
import 'package:explore_egypt/services/token_storage_services.dart';

class AuthServices {
  final ApiService _apiService;
  final StorageServices _storageServices;
  AuthServices(this._apiService, this._storageServices);
  Future<dynamic> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await _apiService.dio.post(
        'register',
        data: {'email': email, 'username': username, 'password': password},
      );
      return response.data;
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.dio.post(
        'login',
        data: {'username': email, 'password': password},
      );
      Map<String, dynamic> data = response.data;
      bool tokensSaved = await _storageServices.saveAccessToken(
        data['accessToken'],
      );
      if (tokensSaved) {
        print('Login successful, tokens saved');
        return data;
      } else {
        print('Login successful but failed to save tokens');
        // Show error to user
        return false;
      }
    } catch (e) {}
  }
}
