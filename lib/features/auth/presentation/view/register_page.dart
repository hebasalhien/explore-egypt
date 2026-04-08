import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/main_background.dart';
import 'package:explore_egypt/features/widgets/custom_button.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_password_text_field.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.data)));

            Navigator.pop(context);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: MainBackground(
          child: Form(
            key: formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Text('Sign Up', style: AppTextStyle.heading1),
                  CustomTextField(
                    controller: nameController,
                    validator: Validators.validateName,
                    label: 'User name',
                  ),
                  CustomTextField(
                    controller: emailController,
                    validator: Validators.emailValidator,
                    label: 'Email',
                  ),

                  CustomPasswordTextField(controller: passController),
                  CustomPasswordTextField(
                    controller: confirmPassController,
                    validator: (value) => Validators.validatePassConfirm(
                      value,
                      passController.text,
                    ),
                    label: 'Confirm Password',
                    textInputAction: TextInputAction.done,
                  ),

                  CustomButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await context.read<AuthCubit>().register(
                          email: emailController.text,
                          username: nameController.text,
                          password: passController.text,
                        );
                      }
                    },
                    label: 'Sign Up',
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('I already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Login', style: AppTextStyle.caption),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
