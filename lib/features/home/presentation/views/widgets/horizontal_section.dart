import 'package:explore_egypt/features/home/presentation/views/widgets/custom_row.dart';
import 'package:flutter/material.dart';

/// A reusable section that pairs a [CustomRow] header with a horizontal
/// [ListView.builder]. Pass any card widget through [itemBuilder].
class HorizontalSection extends StatelessWidget {
  const HorizontalSection({
    super.key,
    required this.header,
    required this.label,
    required this.itemCount,
    required this.itemHeight,
    required this.itemBuilder,
    this.onPressed,
  });

  final String header;
  final String label;
  final int itemCount;
  final double itemHeight;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        CustomRow(
          header: header,
          label: label,
          onPressed: onPressed ?? () {},
        ),
        SizedBox(
          height: itemHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}
