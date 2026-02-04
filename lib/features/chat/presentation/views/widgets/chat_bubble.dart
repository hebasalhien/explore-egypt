import 'package:explore_egypt/core/models/message_model.dart';
import 'package:explore_egypt/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isBot(message.sender)
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 4),
                color: Colors.black.withAlpha(38),
              ),
              BoxShadow(
                blurRadius: 6.1,
                spreadRadius: 0,
                offset: Offset(0, 4),
                color: Colors.black.withAlpha(26),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(19),
              topRight: Radius.circular(19),
              bottomLeft: isBot(message.sender) ? Radius.zero : Radius.circular(19),
              bottomRight: isBot(message.sender) ? Radius.circular(19) : Radius.zero,
            ),
            color: isBot(message.sender) ? AppConstants.kWhite : AppConstants.kPrimaryColor,
          ),
          child: Text(
            message.content,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: isBot(message.sender) ? Colors.black : Colors.white,
              letterSpacing: 0,
            ),
            softWrap: true,
          ),
        ),
        if (isBot(message.sender))
          IconButton(
            icon: Icon(Icons.copy_rounded, size: 24, color: AppConstants.kGrey),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: message.content));
            },
          ),
      ],
    );
  }
  bool isBot (String sender) {
    if (sender == 'bot') {
      return true;
    }
return false;
}
}
