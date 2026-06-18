import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/features/home/model/entities/plan_card_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:explore_egypt/features/plans/presentation/view/widgets/plan_info.dart';
import 'package:explore_egypt/features/plans/presentation/view/widgets/suggested_plan_card_background.dart';
import 'package:explore_egypt/features/plans/presentation/view/widgets/suggested_plan_card_image.dart';
import 'package:flutter/material.dart';

class SuggestedPlansList extends StatelessWidget {
  const SuggestedPlansList({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.planCardModel,
  });

  final double screenHeight;
  final double screenWidth;
  final List<PlanCardModel> planCardModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 2),
        itemBuilder: (contxt, index) => Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Container(
            height: screenHeight * .4,
            width: screenWidth,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Positioned.fill(child: SuggestedPlanCardBG()),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: screenHeight * .15,
                  child: SuggestedPlanCardImage(
                    image: planCardModel[index].imageUrl,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                        child: Text(
                          RegExp(
                                r'\d+\s*days',
                              ).stringMatch(planCardModel[index].subtitle)?.toUpperCase() ?? '3 Days',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(fontSize: 12),
                        ),
                      ),
                      GlassIconButton(opacity: 0),
                    ],
                  ),
                ),

                Positioned(
                  left: 15,
                  right: 8,
                  bottom: screenHeight * .10,
                  child: PlanInfo(
                    screenWidth: screenWidth,
                    title: planCardModel[index].name,
                    subtitle: planCardModel[index].subtitle,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: CustomButton(
                    onPressed: () {},
                    label: 'Add Plan',
                    radius: 26,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        itemCount: planCardModel.length,
      ),
    );
  }
}

