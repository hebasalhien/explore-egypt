import 'package:explore_egypt/services/api_service.dart';
import 'package:explore_egypt/services/auth_services.dart';
import 'package:explore_egypt/services/profile_service.dart';
import 'package:explore_egypt/utils/route_names.dart';
import 'package:explore_egypt/view_models/cubits/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/views/auth/login_page.dart';
import 'package:explore_egypt/views/auth/register_page.dart';
import 'package:explore_egypt/views/chat/chat_page.dart';
import 'package:explore_egypt/views/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final apiService = ApiService();
  runApp(MyApp(authService: AuthServices(apiService)));
}

class MyApp extends StatelessWidget {
  final AuthServices authService;
  const MyApp({super.key, required this.authService});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authService),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RouteNames.login:
              return MaterialPageRoute(builder: (_) => const LoginPage());

            case RouteNames.register:
              return MaterialPageRoute(builder: (_) => const RegisterPage());

            case RouteNames.chatPage:
              return MaterialPageRoute(builder: (_) => ChatPage());

            case RouteNames.profilePage:
              return MaterialPageRoute(builder: (_) => ProfilePage());

            default:
              return MaterialPageRoute(builder: (_) => const LoginPage());
          }
        },
        initialRoute: RouteNames.login,
      ),
    );
  }
}
