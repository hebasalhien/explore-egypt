import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/custom_row.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key,});

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
          automaticallyImplyLeading: false,
          title: Text(
            'ChatBot AI',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    context.read<ChatCubit>().fetchAllConversations();
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: SvgPicture.asset(AppConstants.chatbubbleIcon),
                );
              },
            ),
          ],
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 100,
                color: AppColors.kPrimaryColor,
                child: Center(
                  child: Text(
                    'Conversations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              state.conversations[index].conversationId ??
                                  'No ID',
                                  maxLines: 1,
                            ),
                            onTap: () {
                              context.read<ChatCubit>().fetchConversationById(
                                conversationId:
                                    state.conversations[index].conversationId,
                              );
                              Navigator.pop(context);
                            },
                          );
                        },
                        itemCount: state.conversations.length,
                      );
                    }
                    return Center(child: Text('No conversations found'));
                  },
                ),
              ),
            ],
          ),
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
