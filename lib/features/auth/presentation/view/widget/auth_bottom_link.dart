import 'package:explore_egypt/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AuthBottomLink extends StatelessWidget {
  const AuthBottomLink({super.key, required this.message, required this.actionMessage, required this.onPressed});
  final String message;
  final String actionMessage;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        TextButton(
          onPressed: onPressed,
          child: Text(actionMessage, style: AppTextStyle.caption),
        ),
      ],
    );
  }
}
