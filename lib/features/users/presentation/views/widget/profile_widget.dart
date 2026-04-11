import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/custom_app_bar.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/custom_app_bar_background.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/custom_list_tile.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/user_custom_container.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/user_info.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .41,
              child: Stack(
                children: [
                  Positioned(child: AppBarBackground()),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    top: MediaQuery.of(context).size.height * 0.05,
                    child: CustomAppBar(),
                  ),
                  Positioned.fill(
                    top: 130,
                    left: 0,
                    right: 0,
                    child: UserInfo(
                      name: 'M.Turkey',
                      imageURL:
                          'https://as1.ftcdn.net/jpg/03/23/70/30/1000_F_323703039_3cWWw6oi1HfcBbH7XynKIHUTwhRuMLkF.webp',
                      level: '5',
                    ),
                  ),
                ],
              ),
            ),
            UserCustomContainer(
              bio:
                  'Passionate about history and culture .Currently exploring the wonders of Egypt.',
              text1: 'PLANS MADE',
              number1: '7',
              text2: 'SITES VISITED',
              number2: '23',
              text3: 'NIGHTS BOOKED',
              number3: '14',
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
    );
  }
}

