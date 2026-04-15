import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/gradient_app_bar.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/custom_drawer.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/custom_row.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/message_list.dart';
import 'package:explore_egypt/core/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
      create: (context) => ChatCubit(context.read<ChatRepository>()),
      child: Scaffold(
        appBar: GradientAppBar(
          title: 'ChatBot AI',
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
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
        endDrawer: CustomDrawer(),
        body: Stack(
          children: [
            Positioned.fill(child: BackGround()),
            Column(
              children: [
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
          ],
        ),
      ),
    );
  }
}
