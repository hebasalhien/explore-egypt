import 'package:explore_egypt/helper/api.dart';

class AuthServices {
  Future<dynamic> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      Map<String, dynamic> data = await Api().post(
        uri: 'http://192.168.1.4:83/register.php',
        body: {'user_name': username, 'email': email, 'password': password},
      );
      return data;
    } catch (e) {}
  }
}
