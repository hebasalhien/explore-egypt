import 'package:explore_egypt/core/models/message_model.dart';

class ChatModel {
 final List<MessageModel> messages;
 final String conversationId;
  ChatModel({required this.messages,required this.conversationId});
  factory ChatModel.fromJson(Map<String , dynamic> json) {
    return ChatModel(
conversationId: json['conversationId'],
messages: (json['messages'] as List<dynamic>)
            .map((messageJson) => MessageModel.fromJson(messageJson))
            .toList(),
    );
  }
}