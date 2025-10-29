import 'package:explore_egypt/helper/api.dart';
import 'package:explore_egypt/services/token_storage_services.dart';

class AuthServices {
  Future<dynamic> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      Map<String, dynamic> data = await Api().post(
        uri: 'http://192.168.1.7:83/register.php',
        body: {'user_name': username, 'email': email, 'password': password},
      );
      return data["message"];
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = await Api().post(
        uri: 'http://192.168.1.7:83/login.php',
        body: {'email': email, 'password': password},
      );
      bool tokensSaved = await TokenStorageServices.saveAccessToken(
        data['data']['token'],
      );
      if (tokensSaved) {
        print('Login successful, tokens saved');
        return data;
      } else {
        print('Login successful but failed to save tokens');
        // Show error to user
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
