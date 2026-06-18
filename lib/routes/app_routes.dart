import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/features/auth/model/repos/auth_repository.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/view/forget_password/enter_email_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/forget_password/otp_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/forget_password/reset_pass_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/login_page.dart';
import 'package:explore_egypt/features/auth/presentation/view/register_page.dart';
import 'package:explore_egypt/features/chat/presentation/views/chat_page.dart';
import 'package:explore_egypt/features/help_center/presentation/view/help_center.dart';
import 'package:explore_egypt/features/home/model/data_sources/home_remote_data_source.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/home/model/repos/home_repository.dart';
import 'package:explore_egypt/features/home/presentation/views/home_page.dart';
import 'package:explore_egypt/features/main/presentation/views/main_page.dart';
import 'package:explore_egypt/features/plans/model/data_source/suggested_plans_remote_data_source.dart';
import 'package:explore_egypt/features/plans/model/repo/suggested_plans_repo.dart';
import 'package:explore_egypt/features/plans/presentation/cubit/suggested_plans_cubit.dart';
import 'package:explore_egypt/features/plans/presentation/view/suggested_plans_page.dart';
import 'package:explore_egypt/features/trending/presentation/cubit/landmarks_cubit.dart';
import 'package:explore_egypt/features/trending/presentation/view/trending_page.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';
import 'package:explore_egypt/features/users/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:explore_egypt/features/users/presentation/views/edit_profile_page.dart';
import 'package:explore_egypt/features/users/presentation/views/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

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
  //static const String paymentMethodsPage = 'PaymentMethodsPage';
  static const String helpCenterPage = 'HelpCenterPage';
  static const String trendingPage = 'TrendingPage';
  static const String suggestedPlansPage = 'SuggestedPlansPage';
  static const String editProfilePage = 'EditProfilePage';

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
            create: (context) =>
                ForgotPasswordCubit(context.read<AuthRepository>()),
            child: const EnterEmailPage(),
          ),
        );

      case otpPage:
        // cubit is passed as argument from the previous screen
        final cubit = settings.arguments as ForgotPasswordCubit;
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: cubit, child: const OtpPage()),
        );

      case resetPassPage:
        final cubit = settings.arguments as ForgotPasswordCubit;
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: cubit, child: const ResetPassPage()),
        );

      case chatPage:
        return MaterialPageRoute(builder: (_) => ChatPage());

      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case editProfilePage:
        final userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.read<ProfileCubit>(),
            child: EditProfilePage(userModel: userModel),
          ),
        );
      case helpCenterPage:
        return MaterialPageRoute(builder: (_) => HelpCenterView());
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());

      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());

      case trendingPage:
        final landmarkModel = settings.arguments as List<LandmarkModel>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LandmarksCubit(
              initialLandmarks: landmarkModel,
              homeRepository: HomeRepository(
                HomeRemoteDataSource(ApiService.instance),
              ),

            )..getCategories(),
            child: TrendingPage(),
          ),
        );

      case suggestedPlansPage:
        final plans = settings.arguments as List<PlanCardModel>;

        return MaterialPageRoute(
          builder: (_) {
            final api = ApiService.instance;
            return BlocProvider(
              create: (_) => SuggestedPlansCubit(
                initialPlans: plans,
                homeRepository: HomeRepository(HomeRemoteDataSource(api)),
                suggestedPlansRepo: SuggestedPlansRepo(
                  SuggestedPlansRemoteDataSource(api),
                ),
              )..getCategories(),
              child: SuggestedPlansPage(),
            );
          },
        );

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
