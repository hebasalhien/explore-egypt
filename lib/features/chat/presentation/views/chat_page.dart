import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/gradient_app_bar.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/views/voice_call_screen.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/chat_background.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/custom_drawer.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/custom_row.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/message_list.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/stop_generating.dart';
import 'package:explore_egypt/features/main/presentation/cubit/navigation_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:file_picker/file_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();
  List<PlatformFile> selectedFiles = [];
  String? mode;
  void _openDrawer(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();
    final chatRepository = context.read<ChatRepository>();

    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor:
            Colors.black54, // Matches the standard drawer backdrop dim
        pageBuilder: (context, animation, secondaryAnimation) {
          return MultiBlocProvider(
            providers: [
              RepositoryProvider.value(value: chatRepository),
              BlocProvider.value(value: chatCubit),
            ],
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width:
                    MediaQuery.of(context).size.width * 0.9, // 80% screen width
                child: const CustomDrawer(),
              ),
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(context.read<ChatRepository>()),
      child: Scaffold(
        appBar: GradientAppBar(
          title: 'ChatBot AI',
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    _openDrawer(context);
                  },
                  icon: SvgPicture.asset(
                    AppConstants.chatbubbleIcon,
                    colorFilter: ColorFilter.mode(
                      AppColors.kWhite,
                      BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            ChatBackground(),
            Column(
              children: [
                MessageList(),
                BlocConsumer<ChatCubit, ChatState>(
                  listener: (context, state) {
                    if (state is PlanGeneratied) {
                      setState(() {
                        mode = 'chat'; // Reset mode after generating the plan
                      });
                      context.read<NavigationCubit>().switchTab(
                        2,
                        trip: state.trip,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is MessageSending) {
                      return Column(
                        children: [
                          StopGenerating(
                            onTap: () {
                              context.read<ChatCubit>().stopGenerating();
                            },
                          ),
                        ],
                      );
                    }
                    if (state is MessageLoaded && state.messages.isNotEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 12),
                          RetryBubble(
                            onRetry: () => context
                                .read<ChatCubit>()
                                .regenerateLastMessage(),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 15,
                  ),
                  child: Builder(
                    builder: (context) {
                      return CustomRow(
                        controller: messageController,
                        files: selectedFiles,
                        onFilesChanged: (files) {
                          setState(() {
                            selectedFiles = files;
                          });
                        },
                        onModeChanged: (newMode) {
                          setState(() {
                            mode = newMode;
                          });
                        },
                        onCallPressed: () {
                          if (context.mounted) {
                            final chatCubit = context.read<ChatCubit>();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: chatCubit,
                                  child: const VoiceCallScreen(),
                                ),
                              ),
                            );
                          }
                        },
                        onPressed: (files) {
                          List<String>? filePaths;
                          if (files.isNotEmpty) {
                            filePaths = files.map((e) => e.path!).toList();
                          }

                          context.read<ChatCubit>().sendMessage(
                            message: messageController.text,
                            conversationId: context
                                .read<ChatCubit>()
                                .currentConversationId,
                            filePath: filePaths,
                            mode: mode,
                          );
                          messageController.clear();
                          setState(() {
                            selectedFiles.clear();
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RetryBubble extends StatelessWidget {
  const RetryBubble({super.key, required this.onRetry});

  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: TextButton.icon(
        onPressed: onRetry,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Regenerate', style: TextStyle(color: AppColors.kBlack)),
            Icon(Icons.restart_alt, color: AppColors.kPrimaryVariant),
          ],
        ),
        style: TextButton.styleFrom(backgroundColor: AppColors.kBGColor),
      ),
    );
  }
}
