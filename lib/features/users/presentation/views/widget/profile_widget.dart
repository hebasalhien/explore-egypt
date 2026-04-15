import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/features/users/model/entities/user_model.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/custom_app_bar.dart';
import 'package:explore_egypt/core/widgets/custom_app_bar_background.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/custom_list_tile.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/user_custom_container.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/user_info.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final UserModel userModel;
  const ProfileWidget({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double headerHeight = MediaQuery.of(context).size.height * .41;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: headerHeight),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  UserCustomContainer(
                    bio: userModel.bio == null? 'Bio' : userModel.bio!,
                    number1: userModel.plans,
                    number2: userModel.sites,
                    number3: userModel.nights,
                  ),
                  CustomListTile(
                    title: 'Payment Methods',
                    icon: AppConstants.moneyIcon,
                    route: AppRoutes.paymentMethodsPage,
                  ),
                  CustomListTile(
                    title: 'Account Settings',
                    icon: AppConstants.accountIcon,
                    route: AppRoutes.accountPage,
                  ),
                  CustomListTile(
                    title: 'Help Center',
                    icon: AppConstants.helpIcon,
                    route: AppRoutes.helpPage,
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
                  Positioned(child: AppBarBackground()),
                  Positioned(
                    width: screenWidth,
                    top: screenHeight * 0.05,
                    child: CustomAppBar(),
                  ),
                  Positioned(
                    top: screenHeight * .14,
                    left: 0,
                    right: 0,
                    child: UserInfo(
                      name: userModel.name,
                      imageURL:userModel.imageURL,
                      level: userModel.level,
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
