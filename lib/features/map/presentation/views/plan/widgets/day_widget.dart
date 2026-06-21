import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/delete_confirmation_dialog.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/dashed_rounded_button.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/plan_step_card.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/switch_plan_list.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/total_plans_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
    super.key,
    required this.screenHeight,
    required this.trip,
    required this.screenWidth,
    required this.selectedDay,
  });

  final double screenHeight;
  final TripModel trip;
  final double screenWidth;
  final int selectedDay;

  @override
  Widget build(BuildContext context) {
    if (selectedDay >= trip.dayModel.length) {
      return const Expanded(
        child: Center(child: Text('No data available for this day')),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Column(
          spacing: 20,
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PlanStepCard(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  time: trip.dayModel[selectedDay].activity[index].time,
                  cost: trip.dayModel[selectedDay].activity[index].cost
                      .toString(),
                  title:
                      trip.dayModel[selectedDay].activity[index].landmarkName,
                  subtitle:
                      trip.dayModel[selectedDay].activity[index].description,
                  imageURL: trip.dayModel[selectedDay].activity[index].image,
                );
              },
              itemCount: trip.dayModel[selectedDay].activity.length,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

class PlanTitle extends StatelessWidget {
  final TripModel trip;
  const PlanTitle({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Capture cubit to inject it into the bottom sheet's isolated widget tree
        final planCubit = context.read<PlanCubit>();

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) {
            // Bottom sheet has its own widget tree — inject the same cubit instance
            return BlocProvider.value(
              value: planCubit..getAllPlans(),
              child: Builder(
                builder: (innerContext) {
                  return Container(
                    width: double.infinity,
                    height: MediaQuery.of(innerContext).size.height * 0.7,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Switch Plan',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff4A3728),
                                fontFamily: GoogleFonts.playfair().fontFamily,
                              ),
                            ),
                            subtitle: Text(
                              'Choose which itinerary you want to view',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff6B7280),
                              ),
                            ),
                          ),
                          BlocBuilder<PlanCubit, PlanState>(
                            builder: (context, state) {
                              if (state is GetAllPlansLoading) {
                                return const Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else if (state is GetAllPlansSuccess) {
                                return SwitchPlanList(
                                  plans: state.plans,
                                  
                                );
                              } else if (state is GetAllPlansFailure) {
                                return Expanded(
                                  child: Center(
                                    child: Text(
                                      state.error,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          DashedRoundedButton(
                            onTap: () {},
                            label: 'Create New Plan',
                            color: Color(0xffF3E9D9),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            minWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFFF3E9D9), width: 0.81),
            boxShadow: [
              BoxShadow(
                color: Color(0x0D000000), // #0000000D → ARGB = 0D000000
                offset: Offset(0, 0.81),
                blurRadius: 1.62,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              Icon(Icons.map_outlined),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  trip.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.kBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                CupertinoIcons.chevron_down,
                size: 16,
                fontWeight: FontWeight.bold,
              ),
              TotalPlansNumber(),
            ],
          ),
        ),
      ),
    );
  }
}
