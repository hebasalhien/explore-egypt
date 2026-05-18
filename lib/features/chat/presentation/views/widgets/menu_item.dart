import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final IconData iconData;

  const MenuItem({super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Icon(iconData, color: Colors.black),
        Text(text, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}