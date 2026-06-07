import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.isSelected,
    required this.onTap,
  });
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE5E7EB)),
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.kWhite,
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.kSecondary,
                            AppColors.kPrimaryColor,
                          ],
                        )
                      : null,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                child: Center(
                  child: Text(
                    'Trending',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: isSelected ? AppColors.kWhite : AppColors.kBlack,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
