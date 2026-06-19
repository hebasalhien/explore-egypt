import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/auth_bottom_link.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_password_text_field.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFormComponents extends StatelessWidget {
  const RegisterFormComponents({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passController,
    required this.confirmPassController,
    required this.formKey,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
final double keyboardHeight = View.of(context).viewInsets.bottom;
  final bool isKeyboardOpen = keyboardHeight > 0;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: isKeyboardOpen ? 10 : 20,
        children: [
          SizedBox(height: isKeyboardOpen ? 10 : 70),
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
            validator: (value) =>
                Validators.validatePassConfirm(value, passController.text),
            label: 'Confirm Password',
            textInputAction: TextInputAction.done,
          ),
      
          CustomButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await context.read<AuthCubit>().register(
                  email: emailController.text.trim(),
                  username: nameController.text.trim(),
                  password: passController.text.trim(),
                );
              }
            },
            label: 'Sign Up',
          ),
          AuthBottomLink(
            message: 'I already have an account?',
            actionMessage: 'Login',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
  }
}
