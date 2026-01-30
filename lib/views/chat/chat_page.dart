import 'package:explore_egypt/views/chat/widgets/chat_bubble.dart';
import 'package:explore_egypt/views/chat/widgets/message_text_field.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  final List messages = const [
    {
      'isBot': false,
      'message': "I would like to know more about Egypt's history.",
    },
    {'isBot': true, 'message': "ok i will tell you about it"},
    {
      'isBot': true,
      'message':
                'Egypt has a rich and ancient history that dates back to around 3100 BC when Upper and Lower Egypt were unified under the first pharaoh, Narmer. The civilization of ancient Egypt is renowned for its monumental architecture, including the iconic pyramids, temples, and tombs. The Egyptians made significant advancements in various fields such as writing (hieroglyphics), mathematics, medicine, and engineering.Egypt has a rich and ancient history that dates back to around 3100 BC when Upper and Lower Egypt were unified under the first pharaoh, Narmer. The civilization of ancient Egypt is renowned for its monumental architecture, including the iconic pyramids, temples, and tombs. The Egyptians made significant advancements in various fields such as writing (hieroglyphics), mathematics, medicine, and engineering.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ChatBot AI'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  isBot: messages[index]['isBot']!,
                  message: messages[index]['message']!,
                ) ;
              },
            ),
          ),
          Padding(padding:  EdgeInsets.all(8.0),
          child: MessageTextField(
            controller: TextEditingController(),
            onSubmitted: (value) {
              // Handle message submission
            },
            onPressed: () {
              // Handle send button press
            },
          ),
          ),
        ],
      ),
    );
  }
}
