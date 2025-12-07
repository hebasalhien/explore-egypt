import 'package:explore_egypt/utils/constants.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onPressed
  });
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,

      cursorColor: AppConstants.kPrimaryColor,
      scrollPhysics: ScrollPhysics(parent: BouncingScrollPhysics()),
      decoration: InputDecoration(
        hint: Text('Message', style: TextStyle(fontSize: 22)),
        contentPadding: EdgeInsets.all(10),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.send, color: AppConstants.kPrimaryColor, size: 30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppConstants.kPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppConstants.kPrimaryColor),
        ),
      ),
    );
  }
}
