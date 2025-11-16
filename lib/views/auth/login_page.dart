import 'package:explore_egypt/utils/constants.dart';
import 'package:explore_egypt/utils/validators.dart';
import 'package:explore_egypt/view_models/cubits/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/views/auth/register_page.dart';
import 'package:explore_egypt/views/widgets/background.dart';
import 'package:explore_egypt/views/widgets/custom_button.dart';
import 'package:explore_egypt/views/widgets/custom_password_text_field.dart';
import 'package:explore_egypt/views/widgets/custom_text_field.dart';
import 'package:explore_egypt/views/widgets/custom_wave_shape.dart';

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
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
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
          return Stack(
            clipBehavior: Clip.none,
            children: [
              BackGround(),

              CustomWaveShape(),
               SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16),
                   child: Form(
                     key: formKey,
                     child: SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                       child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 30,
                                color: AppConstants.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomTextField(
                              controller: emailController,
                              validator: Validators.emailValidator,
                              label: 'Email',
                            ),
                            CustomPasswordTextField(controller: passController),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                        
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forget Password?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CustomButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                 await context.read<AuthCubit>().login(
                                    email: emailController.text,
                                    password: passController.text,
                                  );
                                }
                              },
                              label: 'Login',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have account?'),
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
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: AppConstants.kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                     ),
                   ),
                 ),
               ),
            ],
          );
        },
      ),
    );
  }
}
