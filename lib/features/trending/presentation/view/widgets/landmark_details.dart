import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandmardDetails extends StatelessWidget {
  const LandmardDetails({
    super.key,
    required this.type,
    required this.data,
    this.icon,
    this.svgIcon,
  });

  final String type;
  final String data;
  final IconData? icon;
  final String? svgIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffF8EFE5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: icon != null
                ? Icon(icon, color: AppColors.kPrimaryVariant, size: 26)
                : SvgPicture.asset(svgIcon!, width: 12, height: 12),
          ),
        ),
        Text(
          type,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.textCaption,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.kBlack,
          ),
        ),
      ],
    );
  }
}