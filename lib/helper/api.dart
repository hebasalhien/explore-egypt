import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> post({
    required String uri,
    @required dynamic body,
    // @required String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    // if (token != null) {
    //   headers.addAll({'Authorization': 'Bearer $token'});
    // }
    http.Response response = await http.post(
      Uri.parse(uri),
      body: jsonEncode(body),
      headers: headers,
    );
      if (response.statusCode >= 200 && response.statusCode <=299) {
      if (response.body.isEmpty) {
        throw Exception("Empty response body from server");
      }

      return jsonDecode(response.body);
    } else {
      throw Exception('HTTP Error ${response.statusCode}: ${response.body}');
    }
  }
}
