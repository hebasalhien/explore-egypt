import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/users/model/data_sources/user_remote_data_source.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';

class UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepository(this._remoteDataSource);
  /// it calls the remote data source to get user data
  Future<UserModel> getUserData() async{
    try{
      return await _remoteDataSource.getUserData();
    }on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException('An unexpected error occurred');
    } 
  }
  /// it calls the remote data source to update user data
  Future<UserModel> updateUserData({
    String? image,
    String? userName,
    String? bio,
  }) async {
    try {
      return await _remoteDataSource.updateUserData(
        image: image,
        userName: userName,
        bio: bio,
      );
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException('An unexpected error occurred');
    }
  }
}
