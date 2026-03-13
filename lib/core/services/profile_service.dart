import 'package:dio/dio.dart';
import 'package:explore_egypt/core/models/user_model.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';

class ProfileService {
   ProfileService();
  Future<dynamic> getUserProfile() async {
    try {
      final response = await ApiService.instance.dio.get('profile');

      final userModel = UserModel.fromjson(response.data);
      await SharedPrefHelper.setObject('user', userModel.toJson());
      return userModel;
    } on DioException {
      throw Exception('Failed to fetch profile');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
