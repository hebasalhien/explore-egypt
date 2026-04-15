import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:explore_egypt/features/auth/model/repos/auth_repository.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/main_background.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_password_text_field.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_text_field.dart';
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
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.data)));
              Navigator.pushReplacementNamed(context, AppRoutes.mainPage);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return MainBackground(
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
                        style: AppTextStyle.heading1,
                      ),
                      CustomTextField(
                        controller: emailController,
                        validator: Validators.generalValidator,
                        label: 'Email',
                      ),
                      CustomPasswordTextField(
                        controller: passController,
                        validator: Validators.generalValidator,
                        textInputAction: TextInputAction.done,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.forgotPassPage,
                              );
                            },
                            child: Text(
                              'Forget Password?',
                              style: AppTextStyle.hint,
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
                              Navigator.pushNamed(
                                context,
                                AppRoutes.registerPage,
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: AppTextStyle.caption,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
