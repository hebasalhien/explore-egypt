import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.isObscure = false,
    required this.validator,
    required this.label,
    this.sufixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });
  final TextEditingController controller;
  final bool isObscure;
  final String? Function(String?)? validator;
  final String label;
  final Widget? sufixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kPrimaryVariant, width: 0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kErrorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kErrorColor),
        ),
        hint: Text(
          label,
          style: TextStyle(fontSize: 16, color: AppColors.kGrey),
        ),
        suffixIcon: sufixIcon,
        fillColor: AppColors.kWhite,
        filled: true,
      ),
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
    );
  }
}
