import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/auth_form.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_password_text_field.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({super.key});

  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginPage,
              (route) => false,
            );
          } else if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: AuthForm(
          formKey: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text('Reset Password', style: AppTextStyle.heading1),
              SvgPicture.asset(
                AppConstants.resetPasswordImage,
                height: 200,
                width: 243,
              ),
              CustomPasswordTextField(
                controller: _passController,
                label: 'New Password',
                textInputAction: TextInputAction.next,
              ),
              CustomPasswordTextField(
                controller: _confirmPassController,
                validator: (value) => Validators.validatePassConfirm(
                  value,
                  _passController.text,
                ),
                label: 'Confirm Password',
                textInputAction: TextInputAction.done,
              ),
              CustomButton(
                label: 'Reset Password',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ForgotPasswordCubit>().resetPassword(
                      newPassword: _passController.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
