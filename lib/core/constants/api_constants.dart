import 'package:explore_egypt/core/config/app_config.dart';

class ApiConstants {
  static final baseUrl = AppConfig.backendUrl;
  //auth endpoints //
  static const String auth = 'api/auth/';
  static const String login = 'login';
  static const String register = 'register';
  static const String refreshToken = 'refresh';
  static const String forgetPassword = '$auth/forgot-password';
  static const String resetPassword = '$auth/reset-password';

  //user endpoints //
  static const String profile = 'profile';

  //chat endpoints //
  static const String chats = 'api/chats';

  /// home endpoints
  static const String home = 'api/home';
}
