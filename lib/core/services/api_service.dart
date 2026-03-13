import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:explore_egypt/core/constants/storage_constatnts.dart';
import 'package:explore_egypt/core/services/shared_pref_helper.dart';
import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static ApiService? _instance;

  late final Dio dio;
  late final SessionCubit sessionCubit;
  late final PersistCookieJar cookieJar;


  bool _isRefreshing = false;
static const _skipRefreshEndpoints = [
    ApiConstants.login,
    ApiConstants.register,
    ApiConstants.refreshToken,
    ApiConstants.forgetPassword,
    ApiConstants.resetPassword,
  ];
  ApiService._internal();

  static ApiService get instance {
    if (_instance == null) {
      throw Exception('ApiService not initialized. Call ApiService.create() first.');
    }
    return _instance!;
  }
static Future<ApiService> create({required SessionCubit sessionCubit}) async {
  if (_instance == null) {
    _instance = ApiService._internal();
    await _instance!._init(sessionCubit);
  }
  return _instance!;
}

  Future<void> _init(SessionCubit cubit) async {
    sessionCubit = cubit;

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    final appDocDir = await getApplicationDocumentsDirectory();
     cookieJar = PersistCookieJar(
      storage: FileStorage('${appDocDir.path}/.cookies/'),
    );
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: onRequest, onError: onError),
    );
  }


  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SharedPrefHelper.getSecuredString(
      StorageConstants.userToken,
    );
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    debugPrint("request headers: ${options.headers}");
    handler.next(options);
  }

  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('Request error: ${error.message}');
    if (error.response?.statusCode == 401) {
      debugPrint('Unauthorized error, attempting token refresh');
      if (_skipRefreshEndpoints.contains(error.requestOptions.path)) {
        debugPrint('Skipping token refresh for endpoint: ${error.requestOptions.path}');
        return handler.next(error);
      }
      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          // Call refresh token endpoint
          final refreshResponse = await dio.post(ApiConstants.refreshToken);

          if (refreshResponse.statusCode == 200) {
            // 👇 Get new token from response
            final newToken = refreshResponse.data[StorageConstants.userToken];

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
  }
}
