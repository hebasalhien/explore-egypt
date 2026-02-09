import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:explore_egypt/core/constants/storage_constatnts.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static ApiService? _instance;

  late final Dio dio;
  late final SessionCubit sessionCubit;

  bool _isRefreshing = false;

  ApiService._internal();

  factory ApiService({SessionCubit? sessionCubit}) {
    if (_instance == null) {
      _instance = ApiService._internal();
      _instance!._init(sessionCubit);
    }
    return _instance!;
  }

  void _init(SessionCubit? cubit) {
    if (cubit == null) {
      throw Exception(
        'SessionCubit must be provided the first time ApiService is created',
      );
    }

    sessionCubit = cubit;

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

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
          final token = await SharedPrefHelper.getSecuredString(
            StorageConstants.userToken,
          );

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          debugPrint("request headers: ${options.headers}");

          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            if (error.requestOptions.path == ApiConstants.refreshToken) {
              await sessionCubit.endSession();
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
                  final newToken =
                      refreshResponse.data[StorageConstants.userToken];

                  if (newToken != null) {
                    // Save new token
                    await SharedPrefHelper.setSecureString(
                      StorageConstants.userToken,
                      newToken,
                    );

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
                await sessionCubit.endSession();
                _isRefreshing = false;
                return handler.next(error);
              } catch (e) {
                debugPrint('Token refresh error: $e');
                await sessionCubit.endSession();
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
