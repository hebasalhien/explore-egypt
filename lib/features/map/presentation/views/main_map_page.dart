import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/gradient_app_bar.dart';
import 'package:explore_egypt/features/map/presentation/views/map_page.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan_page.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class MainMapPage extends StatelessWidget {
  final TripModel? trip;
  const MainMapPage({super.key, this.trip});


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.kPlanPageBgColor,
        appBar: GradientAppBar(bottom: CustomTabBar()),
        body: TabBarView(
          children: [
            PlanPage(screenHeight: screenHeight,screenWidth: screenWidth,trip: trip,),
            MapPage()
          ],
        ),
      ),
    );
  }
}

