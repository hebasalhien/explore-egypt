import 'package:explore_egypt/features/chat/presentation/views/chat_list_page.dart';
import 'package:flutter/material.dart';
import 'package:explore_egypt/features/auth/presentation/view/login_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/register_page.dart';
import 'package:explore_egypt/features/chat/presentation/views/chat_page.dart';
import 'package:explore_egypt/features/home/presentation/views/home_page.dart';
import 'package:explore_egypt/features/main/presentation/views/main_page.dart';
import 'package:explore_egypt/features/profile/presentation/views/profile_page.dart';

class AppRoutes{
    static const String loginPage = 'LoginPage';
  static const String registerPage = 'RegisterPage';
  static const String chatPage = 'ChatPage';
  static const String profilePage = 'ProfilePage';
  static const String mainPage = 'MainPage';
  static const String homePage = 'HomePage';
  static const String chatListPage = 'ChatListPage';

    static Route<dynamic> onGenerateRoute(settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case registerPage:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case chatPage:
        return MaterialPageRoute(builder: (_) => ChatPage());

      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());

      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());

      case chatListPage:
        return MaterialPageRoute(builder: (_) => const ChatListPage());  

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}