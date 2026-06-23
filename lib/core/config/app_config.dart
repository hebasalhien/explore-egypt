import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();
  static String get mapTilerKey => dotenv.env['MAPTILER_KEY']!;

  static String get backendUrl => dotenv.env['BACKEND_URL']!;

  static String get mapStyle =>
      'https://api.maptiler.com/maps/019e5b83-9d95-791b-be05-28fcc0c224ba/style.json?key=$mapTilerKey';
  
  static String get voiceUrl => dotenv.env['VOICE_CALL_URL']!;
  
}