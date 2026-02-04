import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/core/utils/route_names.dart';
import 'package:explore_egypt/features/auth/presentation/view/login_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/register_page.dart';
import 'package:explore_egypt/features/chat/presentation/views/chat_page.dart';
import 'package:explore_egypt/features/home/presentation/views/home_page.dart';
import 'package:explore_egypt/features/main/presentation/views/main_page.dart';
import 'package:explore_egypt/features/profile/presentation/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionCubit()..restoreSession(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        home: BlocBuilder<SessionCubit, SessionState>(
          builder: (context, state) {
            if (state is SessionAuthenticated) {
              return MainPage();
            } else if (state is SessionUnauthenticated) {
              return const LoginPage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Route<dynamic> onGenerateRoute(settings) {
        switch (settings.name) {
          case RouteNames.loginPage:
            return MaterialPageRoute(builder: (_) => const LoginPage());
  
          case RouteNames.registerPage:
            return MaterialPageRoute(builder: (_) => const RegisterPage());
  
          case RouteNames.chatPage:
            return MaterialPageRoute(builder: (_) => ChatPage());
  
          case RouteNames.profilePage:
            return MaterialPageRoute(builder: (_) => ProfilePage());
  
          case RouteNames.mainPage:
            return MaterialPageRoute(builder: (_) => MainPage());
  
          case RouteNames.homePage:
            return MaterialPageRoute(builder: (_) => HomePage());
  
          default:
            return MaterialPageRoute(builder: (_) => const LoginPage());
        }
      }
}
