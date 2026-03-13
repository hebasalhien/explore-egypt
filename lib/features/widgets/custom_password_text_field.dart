import 'package:explore_egypt/core/utils/validators.dart';
import 'package:explore_egypt/features/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final TextInputAction textInputAction;
  const CustomPasswordTextField({
    super.key,
    required this.controller,
    this.validator = Validators.passwordValidatore,
    this.textInputAction = TextInputAction.next,
    this.label = 'Password',
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      validator: widget.validator,
      label: widget.label,
      isObscure: _isObscure,
      sufixIcon: ExcludeFocus(
        child: IconButton(
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          icon: Icon(
            _isObscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
    );
  }
}
