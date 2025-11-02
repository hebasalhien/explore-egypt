import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:explore_egypt/services/token_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  // Future<dynamic> post({
  //   required String uri,
  //   @required dynamic body,
  //   @required String? token,
  // }) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //   };
  //   if (token != null) {
  //     headers.addAll({'Authorization': 'Bearer $token'});
  //   }
  //   http.Response response = await http.post(
  //     Uri.parse(uri),
  //     body: jsonEncode(body),
  //     headers: headers,
  //   );
  //     if (response.statusCode >= 200 && response.statusCode <=299) {
  //     if (response.body.isEmpty) {
  //       throw Exception("Empty response body from server");
  //     }

  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('HTTP Error ${response.statusCode}: ${response.body}');
  //   }
  // }
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
