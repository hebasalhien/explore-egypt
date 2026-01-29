import 'package:explore_egypt/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.isSentByMe, required this.message});
  final bool isSentByMe;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(19),
            topRight: Radius.circular(19),
            bottomRight: isSentByMe ? Radius.zero : Radius.circular(19),
            bottomLeft: isSentByMe ? Radius.circular(19) : Radius.zero,
          ),
          color: isSentByMe ? AppConstants.kPrimaryColor : Color(0XFFF8F9F7),
        ),
        child: Text(message,style: TextStyle(fontSize: 16,color: Colors.white),),
      ),
    );
  }
}
