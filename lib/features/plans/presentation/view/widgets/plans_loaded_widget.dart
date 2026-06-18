import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/categories_list.dart';
import 'package:explore_egypt/core/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/custom_search_bar.dart';
import 'package:explore_egypt/features/plans/model/entities/categories_model.dart';
import 'package:explore_egypt/features/plans/presentation/view/widgets/suggested_plans_list.dart';
import 'package:flutter/material.dart';

class PlansLoaddedWidget extends StatelessWidget {
  const PlansLoaddedWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.planCardModel,
    required this.categories, required this.selectedCategoryId,
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
        CategoriesList(categories: categories, selectedCategoryId: selectedCategoryId),
        SuggestedPlansList(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          planCardModel: planCardModel,
        ),
      ],
    );
  }
}
