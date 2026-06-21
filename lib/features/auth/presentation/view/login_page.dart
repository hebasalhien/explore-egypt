import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/features/auth/model/repos/auth_repository.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/auth_form.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/login_form_components.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(context.read<AuthRepository>()),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              final sessionCubit = context.read<SessionCubit>();
              sessionCubit.startSession(state.data);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.data['message'])));
              Navigator.pushReplacementNamed(context, AppRoutes.mainPage);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return AuthForm(
              formKey: formKey,
              child: LoginFormComponents(
                emailController: emailController,
                passController: passController,
                formKey: formKey,
              ),
            );
          },
        ),
      ),
    );
  }
}