import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Nile Cruise',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(
                color: Colors.white,
              ),
        ),
        Text(
          '7 Days: The Grand Nile Tour',
          style: Theme.of(
            context,
          ).textTheme.labelLarge,
          softWrap: true,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
            ),
            backgroundColor: Colors.white,
            fixedSize: Size(
              screenWidth * .6,
              40,
            ),
          ),
          child: Text(
            'View Route',
            style: TextStyle(
              color: Color(0xff8B4513),
            ),
          ),
        ),
      ],
    );
  }
}

