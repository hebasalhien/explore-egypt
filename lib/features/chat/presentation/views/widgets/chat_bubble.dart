import 'package:explore_egypt/features/chat/model/entities/message_model.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isBot(message.sender)
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
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
              bottomLeft: isBot(message.sender)
                  ? Radius.zero
                  : Radius.circular(19),
              bottomRight: isBot(message.sender)
                  ? Radius.circular(19)
                  : Radius.zero,
            ),
            color: isBot(message.sender)
                ? AppColors.kWhite
                : AppColors.kPrimaryColor,
          ),
          child: isBot(message.sender)
              ? MarkdownBody(
                  data: message.content,
                  shrinkWrap: true,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: 0,
                    ),
                  ),
                )
              : Text(
                  message.content,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 0,
                  ),
                  softWrap: true,
                ),
        ),
        if (isBot(message.sender))
          IconButton(
            icon: Icon(Icons.copy_rounded, size: 24, color: AppColors.kWhite),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: message.content));
            },
          ),
      ],
    );
  }

  bool isBot(String sender) {
    if (sender == 'bot') {
      return true;
    }
    return false;
  }
}
