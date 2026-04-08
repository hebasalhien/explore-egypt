import 'package:explore_egypt/features/auth/model/repos/auth_repository.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/view/forget_password/enter_email_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/forget_password/otp_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/forget_password/reset_pass_page.dart';
import 'package:flutter/material.dart';
import 'package:explore_egypt/features/auth/presentation/view/login_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/register_page.dart';
import 'package:explore_egypt/features/chat/presentation/views/chat_page.dart';
import 'package:explore_egypt/features/home/presentation/views/home_page.dart';
import 'package:explore_egypt/features/main/presentation/views/main_page.dart';
import 'package:explore_egypt/features/users/presentation/views/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String loginPage = 'LoginPage';
  static const String registerPage = 'RegisterPage';
  static const String forgotPassPage = 'ForgotPassPage';
  static const String otpPage = 'OtpPage';
  static const String resetPassPage = 'ResetPassPage';
  static const String chatPage = 'ChatPage';
  static const String profilePage = 'ProfilePage';
  static const String mainPage = 'MainPage';
  static const String homePage = 'HomePage';

  static Route<dynamic> onGenerateRoute(settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case registerPage:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (_) => AuthCubit(ctx.read<AuthRepository>()),
            child: const RegisterPage(),
          ),
        );

      case forgotPassPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordCubit(
              context.read<AuthRepository>(),
            ),
            child: const EnterEmailPage(),
          ),
        );

      case otpPage:
        // cubit is passed as argument from the previous screen
        final cubit = settings.arguments as ForgotPasswordCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: const OtpPage(),
          ),
        );

      case resetPassPage:
        final cubit = settings.arguments as ForgotPasswordCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: const ResetPassPage(),
          ),
        );


      case chatPage:
        return MaterialPageRoute(builder: (_) => ChatPage());

      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());

      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
