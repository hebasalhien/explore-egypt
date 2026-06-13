import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';

class UserRemoteDataSource {
  ///gets user data
  Future<UserModel> getUserData() async {
    final response = await ApiService.instance.dio.get(ApiConstants.profile);
    final userModel = UserModel.fromjson(response.data);
    return userModel;
  }

  ///update user data
  Future<UserModel> updateUserData({
    String? image,
    String? userName,
    String? bio,
  }) async {
    final response = await ApiService.instance.dio.put(
      ApiConstants.profile,
      data: {'username': userName, 'bio': bio, 'userImage': image},
    );
    final message = response.data['message'];
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      final user = getUserData();
      return user;
    }
    return message;
  }
}
