import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/model/entities/landmark_model_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class AddNewPlace extends StatelessWidget {
  const AddNewPlace({super.key, required this.landmark});
  final List<LandmarkModelPlan> landmark;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .7,
      decoration: const BoxDecoration(
        color: Color(0xffFEF8F1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        spacing: 10,
        children: [
          Divider(
            thickness: 5,
            color: Color(0xffE5E7EB),
            indent: 140,
            endIndent: 140,
            radius: BorderRadius.circular(12),
          ),
          Text('Add Place', style: Theme.of(context).textTheme.headlineMedium),
          Text(
            'Add a new stop to Day 1',
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
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: landmark.length,
              itemBuilder: (context, index) => AddPlaceCard(landmark: landmark[index],),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
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
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: AppColors.kWhite),
            ),
          ),
        ],
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
                  image:NetworkImage(landmark.imageUrl),
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
                  '${landmark.priceEgp} EGP',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.kSecondary,
                    fontSize: 14,
                  ),
                ),
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.kSecondary,
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.add, color: AppColors.kWhite),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
