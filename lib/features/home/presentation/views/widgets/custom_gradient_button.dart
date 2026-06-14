import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    required this.screenWidth,
    this.hasIcon = true,
    this.icon,
    required this.title,
    this.topToBottom = true,
  });

  final double screenWidth;
  final bool hasIcon;
  final IconData? icon;
  final String title;
  final bool topToBottom;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<NavigationCubit>().switchTab(1);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),

      child: Ink(
        decoration: BoxDecoration(
          gradient: topToBottom
              ? const LinearGradient(
                  colors: [AppColors.kSecondary, AppColors.kPrimaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1.0],
                )
              : const LinearGradient(
                  colors: [Color(0xffC1514C), Color(0xffE7944F)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0, 1.0],
                ),
          borderRadius: BorderRadius.circular(hasIcon ? 50 : 16),
        ),
        child: Container(
          width: screenWidth ,
          height: 60,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              hasIcon == true
                  ? Icon(icon, color: AppColors.kWhite)
                  : SizedBox.shrink(),
              Text(title, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
