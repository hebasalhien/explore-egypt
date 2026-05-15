import 'package:explore_egypt/core/constants/app_constants.dart';

class SessionUser {
  final String name;
  final String? image;
  final String email;

  SessionUser({required this.name, this.image, required this.email});

  factory SessionUser.fromJson(json) {
    return SessionUser(
      name: json['username'],
      email: json['email'],
      image: json['image'] ?? AppConstants.userImage,
    );
  }
}
