import 'package:explore_egypt/core/local_db/hive_service.dart';
import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/core/theme/app_theme.dart';
import 'package:explore_egypt/features/auth/model/data_sources/auth_remote_data_source.dart';
import 'package:explore_egypt/features/auth/model/repos/auth_repository.dart';
import 'package:explore_egypt/features/onBoarding/presentation/views/on_boarding.dart';
import 'package:explore_egypt/features/users/model/data_sources/user_remote_data_source.dart';
import 'package:explore_egypt/features/users/model/repos/user_repository.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:explore_egypt/features/auth/presentation/view/login_page.dart';
import 'package:explore_egypt/features/main/presentation/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await dotenv.load(fileName: ".env");

  final hiveService = HiveService();
  final sessionCubit = SessionCubit(hiveService);

  await ApiService.create(sessionCubit: sessionCubit);

  // inject UserRepository into SessionCubit after ApiService is ready
  final userRepository = UserRepository(UserRemoteDataSource(ApiService.instance));
  sessionCubit.setUserRepository(userRepository);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(AuthRemoteDataSource(ApiService.instance)),
        ),
        RepositoryProvider(
          create: (_) => userRepository, // ← reuse same instance
        ),
      ],
      child: BlocProvider(
        create: (context) => sessionCubit..restoreSession(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: BlocConsumer<SessionCubit, SessionState>(
        listener: (context, state) {
          if (state is SessionUnauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Session expired. Please log in again.')),
            );
          }
        },
        builder: (context, state) {
          if (state is SessionAuthenticated) {
            return MainPage();
          } else if (state is SessionUnauthenticated) {
            return const LoginPage();
          } else if (state is SessionNeedsOnboarding) {
            return const OnboardingScreen();
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}