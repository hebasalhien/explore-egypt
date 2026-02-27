import 'package:explore_egypt/core/models/message_model.dart';

class ChatModel {
  final List<MessageModel> messages;
  final String conversationId;
  final String title;
  ChatModel({
    required this.messages,
    required this.conversationId,
    required this.title,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      title: json['title'],
      conversationId: json['conversationId'],
      messages: (json['messages'] as List<dynamic>)
          .map((messageJson) => MessageModel.fromJson(messageJson))
          .toList(),
    );
  }
}
