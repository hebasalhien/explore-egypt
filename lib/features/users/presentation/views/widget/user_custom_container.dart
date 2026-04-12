import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/custom_column.dart';
import 'package:explore_egypt/features/users/presentation/views/widget/custom_vertical_divider.dart';
import 'package:flutter/material.dart';

class UserCustomContainer extends StatelessWidget {
  final String bio;
  final int number1;
  final int number2;
  final int number3;
  const UserCustomContainer({
    super.key,
    required this.bio,
    required this.number1,
    required this.number2,
    required this.number3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * .24,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: BoxBorder.all(color: Color(0xffEF8B43), width: .5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            bio,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          Divider(color: AppColors.kGrey, thickness: .5),
          IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomColumn(number: number1, text: 'PLANS MADE'),
                CustomVerticalDivider(),
                CustomColumn(number: number2, text: 'SITES VISITED'),
                CustomVerticalDivider(),
                CustomColumn(number: number3, text: 'NIGHTS BOOKED'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}