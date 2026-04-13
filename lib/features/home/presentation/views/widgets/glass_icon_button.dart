import 'package:flutter/material.dart';

class GlassIconButton extends StatelessWidget {
  const GlassIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.13),
        border: Border.all(color: Color.fromRGBO(255, 255, 255, 0)),
      ),
      child: IconButton(
        icon: Icon(Icons.favorite_outline, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}

