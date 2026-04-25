import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/auth_form.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_text_field.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EnterEmailPage extends StatefulWidget {
  const EnterEmailPage({super.key});

  @override
  State<EnterEmailPage> createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is EmailSent) {
            Navigator.pushNamed(
              context,
              AppRoutes.otpPage,
              arguments: context.read<ForgotPasswordCubit>(),
            );
          }
        },
        child: AuthForm(
          formKey: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text('Forget Password', style: AppTextStyle.heading1),
              SvgPicture.asset(
                AppConstants.forgetPasswordImage,
                height: 200,
              ),
          
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                validator: Validators.generalValidator,
                textInputAction: TextInputAction.done,
              ),
              CustomButton(
                label: 'Send OTP',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ForgotPasswordCubit>().sendOtp(
                      email: _emailController.text,
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
