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
    this.onFieldSubmitted,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.maxLength,
    this.contentPadding,
  });
  final TextEditingController controller;
  final bool isObscure;
  final String? Function(String?)? validator;
  final String label;
  final Widget? sufixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        counterText: '',
        hintText: label,
        suffixIcon: sufixIcon,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      ),
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: AppColors.kPrimaryColor,
      onChanged: onChanged,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      maxLength: maxLength,
    );
  }
}
