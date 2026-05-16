import 'package:dio/dio.dart';

class ExceptionHandleHelper {
  static String handleDioException(DioException e) {
    if (e.response?.data != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic>) {
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
    if (e.type == DioExceptionType.cancel) {
      return 'Request cancelled';
    }
    return 'Registration failed';
  }
}
