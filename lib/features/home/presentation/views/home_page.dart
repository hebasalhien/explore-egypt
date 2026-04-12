import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/session/cubit/session_cubit.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:explore_egypt/features/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double headerHeight = MediaQuery.of(context).size.height * .41;
    return Scaffold(
      backgroundColor: AppColors.kHBGColor,
      body: Stack(
        children: [
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
                      child: Container(
                        width: screenWidth * .8,
                        height: screenHeight * .2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Where to, Explorer?',
                                  style: TextStyle(
                                    fontFamily: 'Noto Serif',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(Icons.mic_none, color: Color(0xFF9F411E)),
                              ],
                            ),
                            Divider(color: AppColors.kGrey, thickness: .5),
                            CustomGradientButton(screenWidth: screenWidth),
                          ],
                        ),
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

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.kSecondary, AppColors.kPrimaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          width: screenWidth * .75,
          height: 60,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Icon(Icons.auto_awesome, color: AppColors.kWhite),
              Text('Ask AI', style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.pl});
  final double pl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        spacing: 10,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.kWhite,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                'https://as1.ftcdn.net/jpg/03/23/70/30/1000_F_323703039_3cWWw6oi1HfcBbH7XynKIHUTwhRuMLkF.webp',
              ),
            ),
          ),
          Text('Welcome back, test!'),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
            padding: EdgeInsets.only(left: pl, right: 0),
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