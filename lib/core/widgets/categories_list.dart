import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:explore_egypt/features/plans/presentation/cubit/suggested_plans_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key, required this.categories});
  final List<CategoriesModel> categories;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = index;
                });
                context.read<SuggestedPlansCubit>().getPlansByCategory(
                  categoryId: widget.categories[index].id,
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE5E7EB)),
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.kWhite,
                  gradient: isSelected == index
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
                    widget.categories[index].name,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: isSelected == index
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
