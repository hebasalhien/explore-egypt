import 'package:explore_egypt/core/errors/exception_handle_helper.dart';

class ServerException implements Exception {
  final ExceptionResult message;
  const ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
}

class TimeoutException implements Exception {
  const TimeoutException();
}