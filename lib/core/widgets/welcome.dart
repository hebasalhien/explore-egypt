import 'package:explore_egypt/features/users/model/entities/user_model.dart';
import 'package:flutter/widgets.dart';

class Welcome extends StatelessWidget {
  final UserModel user;
  const Welcome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome Back, ${user.name}', style: TextStyle(fontSize: 30)),
    );
  }
}
