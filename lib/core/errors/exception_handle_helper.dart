import 'package:dio/dio.dart';

enum DioExceptionType2 {
  timeout,
  noInternet,
  cancelled,
  serverError,
  unknown,

}

class ExceptionResult {
  final String message;
  final DioExceptionType2 type;

  ExceptionResult({required this.message, required this.type});
}

class ExceptionHandleHelper {
  static ExceptionResult handleDioException(DioException e) {
    if (e.response?.data != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic>) {
        return ExceptionResult(
          message: data['error'].toString(),
          type: DioExceptionType2.serverError,
        );
      }
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return ExceptionResult(
        message: 'Connection timeout. Please try again.',
        type: DioExceptionType2.timeout, // 👈
      );
    }

    if (e.type == DioExceptionType.connectionError) {
      return ExceptionResult(
        message: 'No internet connection. Please check your network.',
        type: DioExceptionType2.noInternet,
      );
    }

    if (e.type == DioExceptionType.cancel) {
      return ExceptionResult(
        message: 'Request cancelled',
        type: DioExceptionType2.cancelled,
      );
    }

    return ExceptionResult(
      message: 'Something went wrong',
      type: DioExceptionType2.unknown,
    );
  }
}