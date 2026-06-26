import 'package:explore_egypt/core/config/app_config.dart';

class ApiConstants {
  static final baseUrl = AppConfig.backendUrl;
  static final voiceUrl = AppConfig.voiceCall;
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
  static const String regenerate = '/regenerate';
  static const String stopGenerating = '/stop';

  /// home endpoints
  static const String home = 'api/home';
  static const String categories = '$home/categories';
  static const String suggestedPlans = '$home/plans';
  static const String favorite = 'api/favorites';
  static const String favoriteLandmarks = '$favorite/landmarks';
  static const String landmarks = '$home/landmarks';
  static const String comments = '/comments';
  /// plan endpoints
  static const String plan = 'api/plans';
  static const String activePlan = '$plan/active';
  static const String savePlan = '$plan/save';
  static const String activatePlan = '/activate';
  static const String deactivatePlan = '/deactivate';
  static const String addDayToPlan = '/days';
  static const String places = '/places';
}
