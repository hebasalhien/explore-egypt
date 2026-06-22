import 'package:flutter/material.dart';

class MapMarker extends StatelessWidget {
  const MapMarker({super.key, required this.number,required this.selected});
  final int number;
  final bool selected;  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 52,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 3, color:selected?const Color(0xffB2001A): Colors.white),
              color: selected?Colors.white:const Color(0xffB2001A),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$number',
                style:  TextStyle(
                  color:selected?const Color(0xffB2001A): Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 4,
              height: 12,
              color: selected?Colors.white:const Color(0xffB2001A),
            ),
          ),
        ],
      ),
    );
  }
}
