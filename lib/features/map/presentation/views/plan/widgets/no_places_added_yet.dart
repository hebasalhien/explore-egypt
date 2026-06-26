import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:explore_egypt/features/main/presentation/cubit/navigation_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/add_new_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoPlacesAddedYet extends StatelessWidget {
  final int day;
  final String planId;
  final String? conversationId;
  const NoPlacesAddedYet({
    super.key,
    required this.day,
    required this.planId,
    required this.conversationId,
  });

  @override
  Widget build(BuildContext context) {
    PlanCubit planCubit = context.read<PlanCubit>();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
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
                'Day ${day + 1} is empty. Start building your \n itinerary by adding your first place.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Color(0xff4D5E6F),
                  fontSize: 12,
                ),
              ),
              CustomButton(
                onPressed: () {
                  planCubit.getLandmarkList();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return BlocProvider.value(
                        value: planCubit,
                        child: AddNewPlace(dayNumber: day, planId: planId),
                      );
                    },
                  );
                },
                label: 'Add Selected Place',
              ),
              ElevatedButton(
                onPressed: () {
                  planCubit.deletePlan(tripId: planId);
                  if (conversationId != null) {
                    context.read<NavigationCubit>().switchTab(
                      1,
                      conversationId: conversationId,
                    );
                  } else {
                    context.read<NavigationCubit>().switchTab(1);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
