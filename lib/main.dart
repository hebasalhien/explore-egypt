import 'package:explore_egypt/services/api_service.dart';
import 'package:explore_egypt/services/auth_services.dart';
import 'package:explore_egypt/services/token_storage_services.dart';
import 'package:explore_egypt/view_models/cubits/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/views/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
   final storageService = StorageServices();
  final apiService = ApiService();
  runApp( MyApp(authService: AuthServices(apiService,storageService),));
}

class MyApp extends StatelessWidget {
    final AuthServices authService;

  const MyApp({super.key,required this.authService});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authService),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()),
    );
  }
}
