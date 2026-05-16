import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StopGenerating extends StatelessWidget {
  final void Function()? onTap;
  const StopGenerating({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * .5,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text('Stop generating...'),
            ],
          ),
        ),
      ),
    );
  }
}
