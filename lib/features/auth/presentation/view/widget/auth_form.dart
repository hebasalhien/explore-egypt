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
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 40 : 0,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: child,
          ),
        ),
      ),
    );
  }
}
