import 'package:explore_egypt/models/user_model.dart';
import 'package:explore_egypt/views/widgets/message_text_field.dart';
import 'package:explore_egypt/views/widgets/welcome.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
      final String username;

  const ChatPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Welcome(username: username)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: MessageTextField(
              controller: messageController,
              onSubmitted: (value) {},
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
