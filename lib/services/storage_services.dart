import 'dart:convert';

import 'package:explore_egypt/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServices {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const String _accessTokenKey = 'access_token';

  Future<void> saveAccessToken(String token) async {
    try {
      await _storage.write(key: _accessTokenKey, value: token);
    } catch (e) {
      throw Exception('Faild to save token: $e');
    }
  }

   Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: _accessTokenKey);
    } catch (e) {
      throw Exception('faild to get token: $e');
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      final userjson = jsonEncode({
        'userId': user.userId,
        'username': user.username,
      });
      await _storage.write(key: 'user_data', value: userjson);
    } catch (e) {
      throw Exception('faild to store user data :$e');
    }
  }

  Future<String?> getUserId() async {
    try {
      final userjson = await _storage.read(key: 'user_data');
      if (userjson == null) return null;
      final userMap = jsonDecode(userjson) as Map<String, dynamic>;
      return userMap['userId'] as String;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> getUsername() async {
    try {
      final userjson = await _storage.read(key: 'user_data');
      if (userjson == null) return null;
      final userMap = jsonDecode(userjson) as Map<String, dynamic>;
      return userMap['username'] as String;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> deleteAllData() async {
    try {
      await _storage.deleteAll();
    } on Exception catch (e) {
      throw ('faild to clear storage :$e');
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final token = await _storage.read(key: _accessTokenKey);
      return token != null;
    } catch (e) {
      return false;
    }
  }
}
