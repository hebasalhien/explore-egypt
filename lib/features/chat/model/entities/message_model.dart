class MessageModel {
  final String sender;
  final String content;
  final String conversationId;
  MessageModel({
    required this.conversationId,
    required this.sender,
    required this.content,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sender: json['sender'],
      content: json['content'] ?? 'plan_created_new',
      conversationId: json['conversationId'],
    );
  }
}
