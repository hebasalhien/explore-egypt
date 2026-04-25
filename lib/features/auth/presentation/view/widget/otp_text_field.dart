import 'package:explore_egypt/features/auth/presentation/view/widget/otp_custom_text_field.dart';
import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({super.key, required this.controllers});

  final List<TextEditingController> controllers;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controllers.length,
        (index) => OtpCustomTextField(controller: controllers[index]),
      ),
    );
  }
}

