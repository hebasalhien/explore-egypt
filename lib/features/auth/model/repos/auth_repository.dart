import 'package:dio/dio.dart';
import 'package:explore_egypt/core/errors/exception.dart';
import 'package:explore_egypt/core/errors/exception_handle_helper.dart';
import 'package:explore_egypt/features/auth/model/data_sources/auth_remote_data_source.dart';

class AuthRepository {
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
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
throw ServerException(ExceptionResult( 
      message: 'An unexpected error occurred',
      type: DioExceptionType2.unknown,
    ));    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      return data;
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult( 
      message: 'An unexpected error occurred',
      type: DioExceptionType2.unknown,
    ));
    }
  }

  Future<String> sendOtp({required String email}) async {
    try {
      await _remoteDataSource.sendOtp(email: email);
      return 'Reset email sent successfully';
    } on DioException catch (e) {
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult(
      message: 'An unexpected error occurred',
      type: DioExceptionType2.unknown,
    ));
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
      throw ServerException(ExceptionHandleHelper.handleDioException(e));
    } catch (e) {
      throw ServerException(ExceptionResult( // 👈
      message: 'An unexpected error occurred',
      type: DioExceptionType2.unknown,
    ));    }
  }



}
