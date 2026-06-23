import 'dart:convert';

class MessageModel {
  final String sender;
  final String? content;
  final String? conversationId;
  final List<String> files;
  final List<String> localPaths;

  /// from server
  MessageModel({
    this.conversationId,
    required this.sender,
    this.content,
    this.files = const [],
    this.localPaths = const []
  });

    bool get isVoice =>
      localPaths.any((p) => _isAudio(p)) || files.any((p) => _isAudio(p));

  bool _isAudio(String path) =>
      path.endsWith('.m4a') ||
      path.endsWith('.mp3') ||
      path.endsWith('.aac') ||
      path.endsWith('.wav');
      
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    String jsonString = json['data'] != null
        ? JsonEncoder.withIndent('  ').convert(json['data'])
        : '';
    return MessageModel(
      sender: json['sender'],
      content: json['content'] ?? jsonString,
      files: List<String>.from(json['attachments'] ?? []),
      conversationId: json['conversationId'],
    );
  }
}
