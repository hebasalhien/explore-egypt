import 'dart:io';

import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/model/entities/message_model.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/voice_bubble.dart';
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
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _scrollToBottom(),
            );
          }
          if (state is ChatTimeout) {
            messages = state.messages;
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _scrollToBottom(),
            );
          }
          if (state is ChatError) {
            return Center(child: Text(state.errorMessage));
          }

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              if (message.sender == 'bot') {
                return ChatBubble(message: message);
              } else {
                return Column(
                  children: [
                  if (message.isVoice)
                    VoiceBubble(message: message),

                  // image/file attachments (non-voice)
                  if (!message.isVoice &&
                      (message.files.isNotEmpty ||
                          message.localPaths.isNotEmpty))
                    FileBubble(message: message),

                  // text content
                  if (message.content != null && message.content!.isNotEmpty)
                    ChatBubble(message: message),
                  ],
                );
              }
            },
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
          );
        },
      ),
    );
  }
}

class FileBubble extends StatelessWidget {
  const FileBubble({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final sources = message.localPaths.isNotEmpty
        ? message
              .localPaths // uploading — show local
        : message.files; // uploaded — show network

    final isLocal = message.localPaths.isNotEmpty;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          margin: const EdgeInsets.all(10),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.end,
            children: sources.map((src) {
              final isImage =
                  src.endsWith('.jpg') ||
                  src.endsWith('.jpeg') ||
                  src.endsWith('.png');

              if (isImage) {
                return _buildImagePreview(src, sources.length, isLocal);
              }
              return _buildFileChip(src);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview(String src, int total, bool isLocal) {
    final size = total == 1 ? 200.0 : 100.0;

    final imageWidget = isLocal
        ? Image.file(File(src), width: size, height: size, fit: BoxFit.cover)
        : Image.network(src, width: size, height: size, fit: BoxFit.cover);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          imageWidget,
          if (isLocal)
            Positioned.fill(
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFileChip(String src) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.insert_drive_file, color: Colors.white),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              src.split('/').last,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
