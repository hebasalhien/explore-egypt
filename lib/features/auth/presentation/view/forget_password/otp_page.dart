import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/auth_form.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/otp_text_field.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  @override
  dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is OtpVerified) {
            Navigator.pushNamed(
              context,
              AppRoutes.resetPassPage,
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
              Text('OTP', style: AppTextStyle.heading1),
              SvgPicture.asset(
                AppConstants.otpImage,
                height: 264,
                width: 264,
              ),
              OtpTextField(controllers: controllers),
              CustomButton(
                label: 'Verify OTP',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    String otp = controllers.map((e) => e.text).join();
                    context.read<ForgotPasswordCubit>().otpVerification(
                      otp: otp,
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
