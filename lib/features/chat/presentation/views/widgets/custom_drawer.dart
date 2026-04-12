import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
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
      backgroundColor: AppColors.kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    color: AppColors.kBlack,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'liber baskerville',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: AppColors.kBlack,
                    size: 30,
                  ),
                ),
              ],
            ),

            Expanded(
              child: BlocProvider(
                create: (context) =>
                    ConversationCubit(context.read<ChatRepository>())
                      ..fetchAllConversations(),
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

            Divider(color: AppColors.kBlack, thickness: 1, height: 1),

            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ChatCubit>().startNewConversation();
                    Navigator.pop(context);
                  },
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.kSecondary,
                    ),
                  ),
                  child: Row(
                    spacing: 7,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.kWhite),
                      Text(
                        'New Chat',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
