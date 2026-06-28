import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/auth/presentation/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class OtpCustomTextField extends StatelessWidget {
  const OtpCustomTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x26000000),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: -1,
            ),
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 4),
              blurRadius: 6.1,
              spreadRadius: -1,
            ),
          ],
        ),
        child: CustomTextField(
          controller: controller,
          validator: Validators.otpValidator,
          keyboardType: TextInputType.number,
          label: '',
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 1,
          contentPadding: EdgeInsets.zero,
          
        ),
      ),
    );
  }
}
