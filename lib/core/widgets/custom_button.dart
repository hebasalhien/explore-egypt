import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double? radius;
  final Color? color;
  const CustomButton({super.key, required this.onPressed, required this.label, this.radius, this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width ,
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(shape:WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius??12))) ),
        child: Text(label,style: Theme.of(context).textTheme.labelSmall!.copyWith(color: color),),
        
      ),
    );
  }
}
