import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateWithAiButton extends StatelessWidget {
  const GenerateWithAiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<NavigationCubit>().switchTab(1);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffFDF2E9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            Icon(Icons.auto_awesome, color: AppColors.kSecondary),
            Text(
              'Generate With AI',
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: AppColors.kSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

