import 'package:dio/dio.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/constants/storage_constatnts.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:flutter/widgets.dart';

class AuthServices {
  Future<dynamic> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await ApiService().dio.post(
        ApiConstants.register,
        data: {'email': email, 'username': username, 'password': password},
      );

      return response.data;
    } on DioException catch (e) {
      String errorMessage = 'Registeration faild';
      if (e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('error')) {
          errorMessage = responseData['error'].toString();
        } else if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          errorMessage = 'Connection Timeout. Please try again.';
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = 'No internet connection. Please check you network.';
        }
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiService().dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      debugPrint('Login response: ${response.headers}');
      Map<String, dynamic> data = response.data;
      debugPrint('login function');
      await SharedPrefHelper.setSecureString(
        StorageConstants.userToken,
        data[StorageConstants.userToken],
      );
      return response.data;
    } on DioException catch (e) {
      String errorMessage = 'Login faild';
      if (e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('error')) {
          errorMessage = responseData['error'].toString();
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Connection Timeout. Please try again.';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection. Please check you network.';
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred:$e');
    }
  }
}
