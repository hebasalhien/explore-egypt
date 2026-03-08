import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:explore_egypt/features/widgets/custom_button.dart';
import 'package:explore_egypt/features/widgets/custom_password_text_field.dart';
import 'package:explore_egypt/features/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is ForgotPasswordInitial ||
                      state is ForgotPasswordError) ...[
                    CustomTextField(
                      controller: _emailController,
                      label: 'email',
                      validator: Validators.generalValidator,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      label: 'Send Reset Link',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgotPasswordCubit>().sendResetEmail(
                            email: _emailController.text,
                          );
                        }
                      },
                    ),
                  ] else if (state is ResetEmailSent) ...[
                    CustomTextField(
                      controller: _emailController,
                      label: 'email',
                      validator: Validators.generalValidator,
                    ),
                    CustomTextField(
                      controller: _otpController,
                      label: 'otp',
                      validator: Validators.generalValidator,
                      keyboardType: TextInputType.number,
                    ),
                    CustomPasswordTextField(
                      controller: _newPassController,
                      label: 'New Password',
                      validator: Validators.generalValidator,
                    ),
                    CustomButton(
                      label: 'Reset Password',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgotPasswordCubit>().resetPassword(
                            email: _emailController.text,
                            otp: _otpController.text,
                            newPassword: _newPassController.text,
                          );
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
