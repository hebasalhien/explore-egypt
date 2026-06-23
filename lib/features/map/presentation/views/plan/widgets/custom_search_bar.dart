import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.hint,
    this.radius,
    this.iconColor,
    this.hintColor,
    this.controller,
    this.onChanged,
  });
  final String hint;
  final double? radius;
  final Color? iconColor;
  final Color? hintColor;
  final TextEditingController? controller;  
  final ValueChanged<String>? onChanged; 
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: iconColor ?? Color(0xff6B7280)),
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor ?? Color(0xff6B7280),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
          borderSide: BorderSide(color: Color(0xffFFF7ED)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
          borderSide: BorderSide(color: Color(0xffFFF7ED)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
          borderSide: BorderSide(color: Color(0xffFFF7ED)),
        ),
      ),
    );
  }
}
