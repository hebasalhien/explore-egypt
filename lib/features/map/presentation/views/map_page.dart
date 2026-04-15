import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/gradient_app_bar.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final trip = TripModel.fromJson(fakeData.fakeTrip);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.kPlanPageBgColor,
        appBar: GradientAppBar(bottom: CustomTabBar()),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                CostWidget(
                  screenHeight: screenHeight,
                  cost: trip.dayModel[0].totalCost,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: PlanStepCard(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        time: trip.dayModel[0].planStep[index].time,
                        cost: trip.dayModel[0].planStep[index].cost,
                        title: trip.dayModel[0].planStep[index].landmarkName,
                        subtitle: trip.dayModel[0].planStep[index].description,
                        imageURL: trip.dayModel[0].planStep[index].image,
                      ),
                    );
                  },
                  itemCount: trip.dayModel[0].planStep.length,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlanStepCard extends StatelessWidget {
  final String time;
  final String cost;
  final String title;
  final String subtitle;
  final String imageURL;
  const PlanStepCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.time,
    required this.cost,
    required this.title,
    required this.subtitle,
    required this.imageURL,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: screenHeight * .17,
      decoration: BoxDecoration(
        color: AppColors.kBGColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.kPrimaryColor,
                ),
              ),
              Text(
                cost,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: AppColors.kBlack),
            ),
            subtitle: Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: Color(0xff64748B)),
              maxLines: 2,
            ),
            trailing: Container(
              width: screenWidth * .16,
              height: screenHeight * .16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: NetworkImage(imageURL)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CostWidget extends StatelessWidget {
  const CostWidget({super.key, required this.screenHeight, required this.cost});
  final String cost;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * .06,
      decoration: BoxDecoration(
        color: AppColors.kBGColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: AppColors.kBlack),
            ),
            Text(
              '60\$',
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: AppColors.kBlack),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.kSecondary, width: 1.5),
          ),
        ),
        child: TabBar(
          tabs: [Text('Plan'), Text('Map')],
          labelStyle: Theme.of(context).textTheme.headlineSmall,
          labelPadding: EdgeInsets.only(top: 10),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
