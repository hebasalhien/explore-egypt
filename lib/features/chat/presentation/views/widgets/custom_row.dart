import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/message_text_field.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.controller,
    required this.onPressed,
  });
  final TextEditingController controller;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        MessageTextField(controller: controller),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor,
            shape: CircleBorder(eccentricity: 0),
            fixedSize: Size(54, 54),
            padding: EdgeInsets.all(0),
          ),
          child: Image.asset(
            AppConstants.sendIcon2,
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}