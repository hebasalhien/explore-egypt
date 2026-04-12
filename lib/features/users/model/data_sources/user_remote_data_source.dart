import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';

class UserRemoteDataSource {
  Future<dynamic> getUserData() async {
    final response = await ApiService.instance.dio.get(ApiConstants.profile);
    final userModel = UserModel.fromjson(response.data);
    return userModel;
  }
}
