import 'package:dio/dio.dart';
import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';

class UserRemoteDataSource {
  final ApiService _apiService;

  UserRemoteDataSource(this._apiService);

  /// gets user data
  Future<UserModel> getUserData() async {
    final response = await _apiService.dio.get(ApiConstants.profile);
    final userModel = UserModel.fromjson(response.data);
    return userModel;
  }

  /// update user data
  Future<UserModel> updateUserData({
    String? image,
    String? userName,
    String? bio,
  }) async {
    MultipartFile? userImage;
    if (image != null && image.isNotEmpty) {
      userImage = await MultipartFile.fromFile(
        image,
        filename: image.split('/').last,
      );
    }
    FormData formData = FormData.fromMap({
      if (userName != null) "username": userName,
      if (bio != null) "bio": bio,
      if (userImage != null) "userImage": userImage,
    });
    final response = await _apiService.dio.put(
      ApiConstants.profile,
      data: formData,
    );
    final message = response.data['message'];
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final user = getUserData();
      return user;
    }
    return message;
  }
}
