import 'package:explore_egypt/features/auth/presentation/view/widget/main_background.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key, required this.formKey, required this.child});

  final GlobalKey<FormState> formKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Form(
        key: formKey,
        child: child,
      ),
    );
  }
}
