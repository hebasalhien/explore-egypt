import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_row.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/home_card_widget.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/landmark_card.dart';
import 'package:explore_egypt/core/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:explore_egypt/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double headerHeight = MediaQuery.of(context).size.height * .41;
    final List<LandmarkModel> landmarks = [
      LandmarkModel(
        title: 'The Pyramids',
        subtitle: 'Giza Plateau',
        image: 'assets/images/pyramid.png',
      ),
      LandmarkModel(
        title: 'The Pyramids',
        subtitle: 'Giza Plateau',
        image: 'assets/images/pyramid.png',
      ),
      LandmarkModel(
        title: 'The Pyramids',
        subtitle: 'Giza Plateau',
        image: 'assets/images/pyramid.png',
      ),
      LandmarkModel(
        title: 'The Pyramids',
        subtitle: 'Giza Plateau',
        image: 'assets/images/pyramid.png',
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.kHBGColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: headerHeight, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  CustomRow(
                    onPressed: () {},
                    header: 'Trending Expeditions',
                    label: 'view all',
                  ),
                  SizedBox(
                    height: screenHeight * .25,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return LandmarkCard(
                          title: landmarks[index].title,
                          subtitle: landmarks[index].subtitle,
                          image: landmarks[index].image,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        );
                      },
                      itemCount: landmarks.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  CustomRow(
                    onPressed: () {},
                    header: 'Suggested Plans',
                    label: 'view all',
                  ),
                  SizedBox(
                    height: screenHeight * .25,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return LandmarkCard(
                          title: landmarks[index].title,
                          subtitle: landmarks[index].subtitle,
                          image: landmarks[index].image,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        );
                      },
                      itemCount: landmarks.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: headerHeight,
              child: Stack(
                children: [
                  Positioned(
                    child: AppBarBackground(
                      colors: [AppColors.kPrimaryColor, AppColors.kSecondary],
                      r1: 0,
                    ),
                  ),
                  Positioned(
                    width: screenWidth,
                    top: screenHeight * 0.05,
                    child: CustomAppBar(pl: screenWidth * .25),
                  ),
                  Positioned(
                    top: screenHeight * .17,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HomeCardWidget(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
          // CustomButton(
          //   onPressed: () {
          //     context.read<SessionCubit>().endSession();
          //     Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
          //   },
          //   label: 'logout',
          // ),