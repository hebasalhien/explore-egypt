import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
  });

  final TextEditingController c1;
  final TextEditingController c2;
  final TextEditingController c3;
  final TextEditingController c4;
  final TextEditingController c5;
  final TextEditingController c6;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 7,
      children: [
        SizedBox(
          width: 48,
          child: CustomTextField(
            controller: c1,
            validator: Validators.otpValidator,
            keyboardType: TextInputType.number,
            label: '',
          ),
        ),

        SizedBox(
          width: 48,
          child: CustomTextField(
            controller: c2,
            validator: Validators.otpValidator,
            label: '',
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: 48,
          child: CustomTextField(
            controller: c3,
            validator: Validators.otpValidator,
            label: '',
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: 48,
          child: CustomTextField(
            controller: c4,
            validator: Validators.otpValidator,
            label: '',
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: 48,
          child: CustomTextField(
            controller: c5,
            validator: Validators.otpValidator,
            label: '',
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: 48,
          child: CustomTextField(
            controller: c6,
            validator: Validators.otpValidator,
            label: '',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }
}
