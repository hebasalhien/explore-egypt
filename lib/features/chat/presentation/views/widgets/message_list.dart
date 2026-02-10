import 'package:explore_egypt/core/models/message_model.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          List<MessageModel> messages = [];

          if (state is MessageLoaded || state is MessageSending) {
            messages = (state as dynamic).messages;
            WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
          }
          if (state is ChatError) {
            return Center(child: Text(state.errorMessage));
          }

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatBubble(message: messages[index]);
            },
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
          );
        },
      ),
    );
  }
}
