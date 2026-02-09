import 'package:explore_egypt/core/services/api_service.dart';
import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:explore_egypt/features/auth/presentation/view/login_page.dart';
import 'package:explore_egypt/features/main/presentation/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final sessionCubit = SessionCubit();

  final apiService = ApiService(sessionCubit: sessionCubit);
  runApp(BlocProvider(
    create: (context) =>sessionCubit..restoreSession(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: BlocConsumer<SessionCubit, SessionState>(
        listener: (context, state) {
          if(state is SessionUnauthenticated){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Session expired. Please log in again.'),
              ),
            );
          }
        },
        builder: (context, state) {
                         if (state is SessionAuthenticated) {
                return MainPage();
              } else if (state is SessionUnauthenticated) {
                return const LoginPage();
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
