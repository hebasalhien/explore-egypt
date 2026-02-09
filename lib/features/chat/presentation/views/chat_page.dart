import 'package:explore_egypt/core/models/message_model.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();
  final List<MessageModel> messages = [];
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
              Expanded(
                child: BlocConsumer<ChatCubit, ChatState>(
                  listener: (context, state) {
                    if(state is MessageSendError){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage),
                        ),
                      );
                    }
                    else if(state is MessageSent){
                      messages.addAll(state.messages);
                      messageController.clear();
                    }
                  },
                  builder: (context, state) {
                    if(state is MessageSent){
                                          return ListView.builder(
                                  itemCount: messages.length,
                                  itemBuilder: (context, index) {
                                    return ChatBubble(message: messages[index],
                                    );
                                  },
                                );
                    }else{return Center(
                      child: Text('Send a message to start chatting!'),
                    );}

                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) {
                    return CustomRow(
                      controller: TextEditingController(),
                      onPressed: () {
context.read<ChatCubit>().sendMessage(
                            message: messageController.text,
                          );
                      },
                    );
                  }
                ),
              ),
            ],
          ),
        ),
    );
  }
}
