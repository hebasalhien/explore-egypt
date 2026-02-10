import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..fetchAllConversations(),
      child: Scaffold(
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChatLoaded) {
              if (state.conversations.isEmpty) {
                return Center(child: Text('No conversations found'));
              }
              return ListView.builder(
                itemCount: state.conversations.length,
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  return ListTile(
                    title: Text('Conversation ${conversation.conversationId}',maxLines: 1,),
                    onTap: () {
Navigator.pushNamed(
                      context,
                      AppRoutes.chatPage,
                      arguments: conversation.conversationId,
                    );                      
                    },
                  );
                },
              );
            } else if (state is ChatError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }
            return Center(child: Text('Chat List Page'));
          },
        ),
      ),
    );
  }
}
