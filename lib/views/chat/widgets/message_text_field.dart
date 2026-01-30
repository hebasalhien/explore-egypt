import 'package:explore_egypt/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onPressed
  });
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 64,
                  spreadRadius: -4,
                  offset: Offset(0, 14),
                  color: AppConstants.kShadowColor.withAlpha(31),
                ),
                BoxShadow(
                  blurRadius: 22,
                  spreadRadius: -6,
                  offset: Offset(0, 8),
                  color: AppConstants.kShadowColor.withAlpha(31),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
            
              cursorColor: AppConstants.kPrimaryColor,
              decoration: InputDecoration(
                
                hint: Text('Generate a name of ...', style: TextStyle(fontSize: 22)),
              
                contentPadding: EdgeInsets.all(10),
            
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color:Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white),
            
                ),
            
                
              ),
            ),
          ),
        ),
ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: SvgPicture.asset(
            AppConstants.sendIcon,
          ),
        ),
      ],
    );
  }
}
