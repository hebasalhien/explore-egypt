import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class NoPlacesAddedYet extends StatelessWidget {
  final int day;
  const NoPlacesAddedYet({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          decoration: BoxDecoration(
            color: Color(0xffFFF9F3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xffFFE5CD)),
            boxShadow: const [
              // Shadow 1
              BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 4),
                blurRadius: 8.0,
                spreadRadius: 2.0,
              ),
              // Shadow 2
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 4),
                blurRadius: 6.1,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Container(
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppConstants.noPlaceAddedImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                'No Places Added Yet',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Day $day is empty. Start building your \n itinerary by adding your first place.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Color(0xff4D5E6F),
                  fontSize: 12,
                ),
              ),
              CustomButton(onPressed: () {}, label: 'Add Selected Place'),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets
                      .zero, // CRITICAL: Removes default padding so gradient fills the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Match your Figma corner radius
                  ),
                  side: BorderSide(color: AppColors.kPrimaryColor),
                  backgroundColor: Color(0xFFFBF7F2),
                ),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.kPrimaryColor,
                      ),
                      Text(
                        'Generate With AI',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
