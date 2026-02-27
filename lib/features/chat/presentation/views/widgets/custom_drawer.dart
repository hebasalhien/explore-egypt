import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/conversation_cubit/conversation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
          ListTile(
            leading: Icon(
              Icons.add_box_outlined,
              color: AppColors.kPrimaryColor,
              size: 26,
            ),

            title: Text('New Chat'),
            onTap: () {
              context.read<ChatCubit>().startNewConversation();
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => ConversationCubit()..fetchAllConversations(),
              child: BlocBuilder<ConversationCubit, ConversationState>(
                builder: (context, state) {
                  if (state is ConversationLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            state.conversations[index].title,
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
                  } else if (state is ConversationLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Center(child: Text('No conversations found'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
