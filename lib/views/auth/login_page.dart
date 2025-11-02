import 'package:explore_egypt/services/auth_services.dart';
import 'package:explore_egypt/view_models/cubits/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/views/auth/register_page.dart';
import 'package:explore_egypt/views/widgets/custom_text_field.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.data['message'])));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                CustomTextField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required field';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: passController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'required field ';
                    }
                    return null;
                  },
                  isObscure: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthCubit>().login(
                        email: emailController.text,
                        password: passController.text,
                      );
                    }
                  },
                  child: Text('Login'),
                ),
                Row(
                  children: [
                    Text('don\'t have account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterPage();
                            },
                          ),
                        );
                      },
                      child: Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
