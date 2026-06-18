import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:flutter/material.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource(this._apiService);

  Future<String> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    final response = await _apiService.dio.post(
      ApiConstants.register,
      data: {'email': email, 'username': username, 'password': password},
    );
    return response.data['message'];
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    debugPrint('Login response: ${response.headers}');

    return response.data;
  }

  Future<dynamic> sendOtp({required String email}) async {
    await _apiService.dio.post(
      ApiConstants.forgetPassword,
      data: {'email': email},
    );
  }

  Future<dynamic> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    await _apiService.dio.post(
      ApiConstants.resetPassword,
      data: {'email': email, 'otp': otp, 'newPassword': newPassword},
    );
  }
}
