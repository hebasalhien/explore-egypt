import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DayCircle extends StatelessWidget {
  final bool isSelected;
  final int dayNum;
  final VoidCallback onTap;

  const DayCircle({
    super.key,
    required this.isSelected,
    required this.dayNum,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.kPrimaryColor : AppColors.kWhite,
              border: Border.all(
                color: AppColors.kPrimaryVariant,
                width: isSelected ? 0 : 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Color(0x4DEF8B43),
                        offset: Offset(0, 4),
                        blurRadius: 6,
                        spreadRadius: -4,
                      ),
                      BoxShadow(
                        color: Color(0x4DEF8B43),
                        offset: Offset(0, 10),
                        blurRadius: 15,
                        spreadRadius: -3,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                'D$dayNum',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: isSelected
                      ? AppColors.kWhite
                      : AppColors.kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
