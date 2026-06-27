import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/categories_list.dart';
import 'package:explore_egypt/core/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/custom_search_bar.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:explore_egypt/features/plans/presentation/cubit/suggested_plans_cubit.dart';
import 'package:explore_egypt/features/plans/presentation/view/widgets/suggested_plans_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PlansLoaddedWidget extends StatelessWidget {
  const PlansLoaddedWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.planCardModel,
    required this.categories,
    required this.selectedCategoryId,
  });

  final double screenHeight;
  final double screenWidth;
  final List<PlanCardModel> planCardModel;
  final List<CategoriesModel> categories;
  final String selectedCategoryId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarBackground(
          r1: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              SizedBox(height: 20),
              Row(
                spacing: 20,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.kWhite),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Suggested Plans',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kWhite,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                child: CustomSearchBar(hint: 'Search Plans', radius: 30),
              ),
            ],
          ),
        ),
        CategoriesList(
          categories: categories,
          selectedCategoryId: selectedCategoryId,
          onCategoryTap: (categoryId) {
            context.read<SuggestedPlansCubit>().getPlansByCategory(
              categoryId: categoryId,
            );
          },
        ),
        SuggestedPlansList(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          planCardModel: planCardModel,
        ),
      ],
    );
  }
}

class PlansLoadingWidget extends StatelessWidget {
  const PlansLoadingWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarBackground(
          r1: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              SizedBox(height: 20),
              Row(
                spacing: 20,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.kWhite),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Suggested Plans',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kWhite,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                child: CustomSearchBar(hint: 'Search Plans', radius: 30),
              ),
            ],
          ),
        ),

        CategoryListLoadingWidget(screenWidth: screenWidth),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: screenHeight * 0.4,
            width: screenWidth * .9,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 12,
                  top: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 5,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 6,
                        ),
                        child: Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 15,
                  right: 8,
                  bottom: screenHeight * .10,
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth * .7,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: screenWidth * .7,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: screenWidth * .7,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryListLoadingWidget extends StatelessWidget {
  const CategoryListLoadingWidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[300],
              ),
              width: screenWidth * .3,
              height: screenWidth * .1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[300],
              ),
              width: screenWidth * .3,
              height: screenWidth * .1,
            ),
          ],
        ),
      ),
    );
  }
}
