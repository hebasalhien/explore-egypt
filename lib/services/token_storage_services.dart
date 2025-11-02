import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServices {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const String _accessTokenKey = 'access_token';
  //static const String _refreshTokenKey = 'refresh_token';

  // Save access token
  // static Future<void> saveAccessToken(String token) async {
  //   await _storage.write(key: _accessTokenKey, value: token);

  // }

   Future<bool> saveAccessToken(String token) async {
    try {
      await _storage.write(key: _accessTokenKey, value: token);

      // Verify the token was saved correctly
      final savedToken = await _storage.read(key: _accessTokenKey);
      return savedToken == token;
    } catch (e) {
      print('Error saving access token: $e');
      return false;
    }
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }
}
