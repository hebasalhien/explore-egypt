import 'package:flutter/widgets.dart';

class Welcome extends StatelessWidget {
  final String username;
  const Welcome( {super.key,required this.username});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Text('Welcome Back, $username',style: TextStyle(fontSize: 30),));
  }
}
