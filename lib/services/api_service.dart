import 'package:dio/dio.dart';
import 'package:explore_egypt/services/storage_services.dart';
import 'package:explore_egypt/utils/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  late Dio dio;
  bool _isRefreshing = false;
  final StorageServices storageServices;
  ApiService(this.storageServices) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
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
          final token = await storageServices.getAccessToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print("Logout headers: ${options.headers}");

          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            if (error.requestOptions.path == ApiConstants.refreshToken) {
              await storageServices.deleteAllData();
              return handler.next(error);
            }

            // Only one thread should refresh at a time
            if (!_isRefreshing) {
              _isRefreshing = true;
              try {
                // Call refresh token endpoint
                final refreshResponse = await dio.post(
                  ApiConstants.refreshToken,
                );

                if (refreshResponse.statusCode == 200) {
                  // 👇 Get new token from response
                  final newToken = refreshResponse.data['accessToken'];

                  if (newToken != null) {
                    // Save new token
                    await storageServices.saveAccessToken(newToken);

                    // Update header for retry
                    error.requestOptions.headers['Authorization'] =
                        'Bearer $newToken';

                    // Retry original request with new token
                    _isRefreshing = false;
                    return handler.resolve(
                      await dio.request(
                        error.requestOptions.path,
                        options: Options(
                          method: error.requestOptions.method,
                          headers: error.requestOptions.headers,
                        ),
                        data: error.requestOptions.data,
                        queryParameters: error.requestOptions.queryParameters,
                      ),
                    );
                  }
                }

                // Refresh failed
                await storageServices.deleteAllData();
                _isRefreshing = false;
                return handler.next(error);
              } catch (e) {
                print('Token refresh error: $e');
                await storageServices.deleteAllData();
                _isRefreshing = false;
                return handler.next(error);
              }
            }
          }
          handler.next(error);
        },
      ),
    );
  }
}
