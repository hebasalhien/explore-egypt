class ApiConstants {
  static const String baseUrl = 'http://192.168.1.3:8083/';
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
}
