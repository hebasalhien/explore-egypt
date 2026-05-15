import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/message_text_field.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.files,
    required this.onFilesChanged,
  });
  final TextEditingController controller;
  final void Function(List<PlatformFile> files) onPressed;
  final List<PlatformFile> files;
  final ValueChanged<List<PlatformFile>> onFilesChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        MessageTextField(
          controller: controller,
          files: files,
          onFilesChanged: onFilesChanged,
        ),
        ElevatedButton(
          onPressed: () => onPressed(files),
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