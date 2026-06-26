import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/model/entities/landmark_model_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/add_day_circle.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewPlace extends StatelessWidget {
  const AddNewPlace({super.key, required this.dayNumber, required this.planId});
  final int dayNumber;
  final String? planId;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .7,
      decoration: const BoxDecoration(
        color: Color(0xffFEF8F1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: BlocBuilder(
        bloc: context.read<PlanCubit>(),
        builder: (context, state) {
          if (state is GetLandmarksSuccess) {
            return Column(
              spacing: 10,
              children: [
                Divider(
                  thickness: 5,
                  color: Color(0xffE5E7EB),
                  indent: 140,
                  endIndent: 140,
                  radius: BorderRadius.circular(12),
                ),
                Text(
                  'Add Place',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'Add a new stop to Day ${dayNumber + 1}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Color(0xff6B7280)),
                ),
                CustomSearchBar(hint: 'Search Place'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        'SUGGESTED PLACES',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff9CA3AF),
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.landmarks.length,
                    itemBuilder: (context, index) =>
                        AddPlaceCard(landmark: state.landmarks[index]),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    context.read<PlanCubit>().addPlaceToDay(
                      day: dayNumber,
                      planId: planId,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kSecondary,
                    foregroundColor: AppColors.kWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    minimumSize: Size(double.infinity, 56),
                  ),
                  child: Text(
                    'Add Selected Place',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.kWhite,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.kSecondary),
            );
          }
        },
      ),
    );
  }
}

class AddPlaceCard extends StatelessWidget {
  const AddPlaceCard({super.key, required this.landmark});
  final LandmarkModelPlan landmark;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          spacing: 12,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(landmark.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  landmark.title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: AppColors.kBlack),
                ),
                Text(
                  landmark.category,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            Spacer(),
            Column(
              spacing: 4,
              children: [
                Text(
                  landmark.priceEgp,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.kSecondary,
                    fontSize: 14,
                  ),
                ),
                ToggleLandmarkButton(landmark: landmark),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleLandmarkButton extends StatefulWidget {
  final LandmarkModelPlan landmark;
  const ToggleLandmarkButton({super.key, required this.landmark});

  @override
  State<ToggleLandmarkButton> createState() => _ToggleLandmarkButtonState();
}

class _ToggleLandmarkButtonState extends State<ToggleLandmarkButton> {
  // 1. Track the selection state locally
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    const toggledColor = Color(0x1AC25454); // #C254541A
    const activeRed = Color(0xFFC25454);

    return _isSelected
        ? CustomPaint(
            painter: DashedCirclePainter(
              color: activeRed,
              strokeWidth: 2.0,
              dashWidth: 5.0,
              dashSpace: 3.0,
            ),
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: toggledColor,
                padding: const EdgeInsets.all(8),
              ),
              onPressed: () {
                // 2. Fire the Cubit event AND update the local UI state
                context.read<PlanCubit>().toggleLandmarkToList(
                  landmarkId: widget.landmark.id,
                );
                // context.read<PlanCubit>().toggleLandmark(
                //   landmarkId: widget.landmark.id,
                // );
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
              icon: const Icon(Icons.close, color: activeRed),
            ),
          )
        : IconButton.filled(
            style: IconButton.styleFrom(backgroundColor: AppColors.kSecondary),
            onPressed: () {
              // 3. Fire the Cubit event AND update the local UI state
              context.read<PlanCubit>().toggleLandmarkToList(
                landmarkId: widget.landmark.id,
              );
              // context.read<PlanCubit>().toggleLandmark(
              //   landmarkId: widget.landmark.id,
              // );
              setState(() {
                _isSelected = !_isSelected;
              });
            },
            icon: Icon(Icons.add, color: AppColors.kWhite),
          );
  }
}
