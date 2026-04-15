import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:explore_egypt/features/auth/presentation/cubit/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/main_background.dart';
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
  final _c1 = TextEditingController();
  final _c2 = TextEditingController();
  final _c3 = TextEditingController();
  final _c4 = TextEditingController();
  final _c5 = TextEditingController();
  final _c6 = TextEditingController();

  @override
  dispose() {
    _c1.dispose();
    _c2.dispose();
    _c3.dispose();
    _c4.dispose();
    _c5.dispose();
    _c6.dispose();

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
                  Text('OTP', style: AppTextStyle.heading1),
                  SvgPicture.asset(
                    AppConstants.otpImage,
                    height: 264,
                    width: 264,
                  ),
                  OtpTextField(
                    c1: _c1,
                    c2: _c2,
                    c3: _c3,
                    c4: _c4,
                    c5: _c5,
                    c6: _c6,
                  ),
                  CustomButton(
                    label: 'Verify OTP',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String otp =
                            _c1.text +
                            _c2.text +
                            _c3.text +
                            _c4.text +
                            _c5.text +
                            _c6.text;
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
        ),
      ),
    );
  }
}
