import 'package:dio/dio.dart';
import 'package:explore_egypt/core/constants/storage_constatnts.dart';
import 'package:explore_egypt/core/errors/failure.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:explore_egypt/features/auth/model/data_sources/auth_remote_data_source.dart';

class AuthRepository{
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepository(this._remoteDataSource);
  
  Future<String> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      return await _remoteDataSource.createUser(
        email: email,
        password: password,
        username: username,
      );
    } on DioException catch (e) {
      throw ServerFailure(_handleDioException(e));
    } catch (e) {
      throw ServerFailure('An unexpected error occurred');
    }
  }

  Future<String>login ({required String email, required String password})async{
    try {
      final data = await _remoteDataSource.login(email: email, password: password);
        await SharedPrefHelper.setSecureString(
        StorageConstants.userToken,
        data[StorageConstants.userToken],
      );
      return data['message'];
    } on DioException catch (e) {
      throw ServerFailure(_handleDioException(e));
    } catch (e) {
      throw ServerFailure('An unexpected error occurred');
    }
  }

  Future<String> sendOtp({required String email}) async {
    try {
      await _remoteDataSource.sendOtp(email: email);
      return 'Reset email sent successfully';
    } on DioException catch (e) {
      throw ServerFailure(_handleDioException(e));
    } catch (e) {
      throw ServerFailure('An unexpected error occurred');
    }
  }

  Future<String> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      return 'Password reset successfully';
    } on DioException catch (e) {
      throw ServerFailure(_handleDioException(e));
    } catch (e) {
      throw ServerFailure('An unexpected error occurred');
    }
  }
  
  String _handleDioException(DioException e) {
  if (e.response?.data != null) {
    final data = e.response!.data;
    if (data is Map<String, dynamic> && data.containsKey('error')) {
      return data['error'].toString();
    }
  }
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return 'Connection timeout. Please try again.';
  }
  if (e.type == DioExceptionType.connectionError) {
    return 'No internet connection. Please check your network.';
  }
  return 'Registration failed';
    }

  
}