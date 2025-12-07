import 'package:explore_egypt/utils/route_names.dart';
import 'package:explore_egypt/view_models/cubits/auth_cubit/auth_cubit.dart';
import 'package:explore_egypt/views/widgets/custom_button.dart';
import 'package:explore_egypt/views/widgets/message_text_field.dart';
import 'package:explore_egypt/views/widgets/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final String username;

  const ChatPage({super.key, required this.username});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(child: Welcome(username: widget.username)),
              CustomButton(
                onPressed: () async {
                  try {
                    await context.read<AuthCubit>().logout();

                    Navigator.pushReplacementNamed(context, RouteNames.login);
                  } on Exception catch (e) {
                    print('an unexpected error happen $e');
                  }
                },
                label: 'logout',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: MessageTextField(
                  controller: messageController,
                  onSubmitted: (value) {},
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
