import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:explore_egypt/core/constants/storage_constants.dart';
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
  final List<Completer<String>> _pendingRefreshCompleters = [];

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
      throw Exception(
        'ApiService not initialized. Call ApiService.create() first.',
      );
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

    if (error.response?.statusCode != 401) {
      return handler.next(error);
    }

    if (_skipRefreshEndpoints.contains(error.requestOptions.path)) {
      debugPrint(
        'Skipping token refresh for endpoint: ${error.requestOptions.path}',
      );
      return handler.next(error);
    }

    // If already refreshing, queue this request and wait for the new token
    if (_isRefreshing) {
      final completer = Completer<String>();
      _pendingRefreshCompleters.add(completer);

      try {
        final newToken = await completer.future;
        return handler.resolve(
          await _retryRequest(error.requestOptions, newToken),
        );
      } catch (_) {
        return handler.next(error);
      }
    }

    // First request to get 401 — do the refresh
    _isRefreshing = true;

    try {
  final refreshResponse = await dio.post(ApiConstants.refreshToken);

  if (refreshResponse.statusCode == 200) {
    final newToken = refreshResponse.data[StorageConstants.userToken];

    if (newToken != null) {
      await SharedPrefHelper.setSecureString(
        StorageConstants.userToken,
        newToken,
      );
      for (final completer in _pendingRefreshCompleters) {
        completer.complete(newToken);
      }
      _pendingRefreshCompleters.clear();

      // Retry — errors here should NOT trigger sign-out
      try {
        return handler.resolve(
          await _retryRequest(error.requestOptions, newToken),
        );
      } catch (retryError) {
        debugPrint('Retry failed after token refresh: $retryError');
        return handler.next(error); // pass original error, don't sign out
      }
    }
  }

  _failPendingRequests();
  await sessionCubit.endSession();
  return handler.next(error);

} catch (e) {
  debugPrint('Token refresh error: $e');
  _failPendingRequests();
  await sessionCubit.endSession();
  return handler.next(error);
} finally {
  _isRefreshing = false;
}
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

Future<Response> _retryRequest(RequestOptions options, String token) {
  // Rebuild FormData if needed — reusing a finalized FormData crashes
  dynamic data = options.data;
  if (data is FormData) {
    final newFormData = FormData();
    newFormData.fields.addAll(data.fields);
    newFormData.files.addAll(data.files);
    data = newFormData;
  }

  return dio.request(
    options.path,
    options: Options(
      method: options.method,
      headers: {...options.headers, 'Authorization': 'Bearer $token'},
    ),
    data: data,
    queryParameters: options.queryParameters,
  );
}
  void _failPendingRequests() {
    for (final completer in _pendingRefreshCompleters) {
      completer.completeError('Token refresh failed');
    }
    _pendingRefreshCompleters.clear();
  }
}
