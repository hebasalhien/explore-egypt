import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:explore_egypt/features/plans/presentation/cubit/suggested_plans_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.categories, required this.selectedCategoryId});
  final List<CategoriesModel> categories;
  final String selectedCategoryId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isCurrentSelected = category.id == selectedCategoryId;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                context.read<SuggestedPlansCubit>().getPlansByCategory(
                  categoryId: categories[index].id,
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE5E7EB)),
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.kWhite,
                  gradient: isCurrentSelected 
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),

                child: Center(
                  child: Text(
                    categories[index].name,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: isCurrentSelected
                          ? AppColors.kWhite
                          : AppColors.kBlack,
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
