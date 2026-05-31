import 'package:flutter/material.dart';

class LocationsNumberContainer extends StatelessWidget {
  const LocationsNumberContainer({super.key, required this.locationsNumber});

  final int locationsNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 90,
      decoration: BoxDecoration(
        color: Color(0xffB2001A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          '$locationsNumber Locations',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
