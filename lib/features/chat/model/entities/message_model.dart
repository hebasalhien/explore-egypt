import 'dart:convert';

class MessageModel {
  final String sender;
  final String? content;
  final String? conversationId;
  final List<String> files;

  /// from server
  final List<String> localPaths;
  MessageModel({
    this.conversationId,
    required this.sender,
    this.content,
    this.files = const [],
    this.localPaths = const []
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    String jsonString = json['data'] != null
        ? JsonEncoder.withIndent('  ').convert(json['data'])
        : '';
    return MessageModel(
      sender: json['sender'],
      content: json['content'] ?? jsonString,
      files: List<String>.from(json['fileUrls'] ?? []),
      conversationId: json['conversationId'],
    );
  }
}
