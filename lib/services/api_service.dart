import 'package:dio/dio.dart';
import 'package:explore_egypt/services/token_storage_services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  
  static const String baseUrl = 'http://10.0.2.2:8081/';
  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageServices.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            handler.next(options);
          }
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {}
          handler.next(error);
        },
      ),
    );
  }
}
