import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/auth_bottom_link.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_password_text_field.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_text_field.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';

class LoginFormComponents extends StatelessWidget {
  const LoginFormComponents({
    super.key,
    required this.emailController,
    required this.passController,
    required this.formKey,
  });

  final TextEditingController emailController;
  final TextEditingController passController;
  final GlobalKey<FormState> formKey;
  void _performLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = View.of(context).viewInsets.bottom;
    final bool isKeyboardOpen = keyboardHeight > 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: isKeyboardOpen ? 10 : 22,
      children: [
        SizedBox(height: isKeyboardOpen ? 20 : 60),
        Text('Login', style: AppTextStyle.heading1),
        CustomTextField(
          controller: emailController,
          validator: Validators.generalValidator,
          label: 'Email',
        ),
        CustomPasswordTextField(
          controller: passController,
          validator: Validators.generalValidator,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _performLogin(context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
    
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.forgotPassPage);
              },
              child: Text('Forget Password?', style: AppTextStyle.hint),
            ),
          ],
        ),
        CustomButton(onPressed: () => _performLogin(context), label: 'Login'),
        AuthBottomLink(
          message: 'Don\'t have account?',
          actionMessage: 'Sign up',
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.registerPage);
          },
        ),
      ],
    );
  }
}
