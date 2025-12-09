import 'package:explore_egypt/views/widgets/message_text_field.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat AI'), centerTitle: true),
      body: Column(
        children: [
          // CustomButton(
          //   onPressed: () async {
          //     try {
          //       await context.read<AuthCubit>().logout();

          //       Navigator.pushReplacementNamed(context, RouteNames.login);
          //     } on Exception catch (e) {
          //       print('an unexpected error happen $e');
          //     }
          //   },
          //   label: 'logout',
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //   child: MessageTextField(
          //     controller: messageController,
          //     onSubmitted: (value) {},
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
    );
  }
}
