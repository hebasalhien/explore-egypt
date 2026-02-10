import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/custom_row.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ChatBot AI',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Divider(color: AppColors.kGrey, thickness: 1),
            MessageList(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return CustomRow(
                    controller: messageController,
                    onPressed: () {
                      context.read<ChatCubit>().sendMessage(
                        message: messageController.text,
                        conversationId: context
                            .read<ChatCubit>()
                            .currentConversationId,
                      );
                      messageController.clear();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
