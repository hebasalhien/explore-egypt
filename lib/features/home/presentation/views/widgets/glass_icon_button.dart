import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GlassIconButton extends StatelessWidget {
  const GlassIconButton({super.key, this.opacity, required this.isFavorite, required this.onPressed});
  final double? opacity;
  final bool isFavorite;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFavorite
            ? AppColors.kWhite
            : Color.fromRGBO(255, 255, 255, opacity != null ? opacity! : 0.13),
        border: Border.all(color: Color.fromRGBO(255, 255, 255, 0)),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: isFavorite
            ? Icon(
                Icons.favorite,
                color: AppColors.kFavoriteIconColor,
                size: 18,
              )
            : Icon(Icons.favorite_outline, color: Colors.white, size: 18),
        onPressed: onPressed,
      ),
    );
  }
}
