import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRow extends StatelessWidget {
  final VoidCallback onPressed;
  final String header;
  final String label;
  const CustomRow({
    super.key,
    required this.onPressed,
    required this.header,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(header, style: Theme.of(context).textTheme.titleMedium),
        TextButton(
          onPressed: onPressed,
          style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontFamily: GoogleFonts.manrope().fontFamily,
              color: label.contains('Live Now')?AppColors.kRowActionColor :  AppColors.kIconButtonColor,
            ),
          ),
        ),
      ],
    );
  }
}
