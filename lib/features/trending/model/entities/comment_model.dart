class CommentModel {
  final String userName;
  final String userImage;
  final String comment;
  final double rating;
  final DateTime createdAt;

  CommentModel({
    required this.userName,
    required this.userImage,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  factory CommentModel.fromjson(json) {
    return CommentModel(
      userName: json['username'],
      userImage: json['userImage'],
      comment: json['message'],
      rating: json['rating'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
