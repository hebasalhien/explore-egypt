import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/delete_confirmation_dialog.dart';
import 'package:explore_egypt/features/chat/model/repos/chat_repository.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:explore_egypt/features/chat/presentation/cubit/conversation_cubit/conversation_cubit.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_gradient_button.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.kPlanPageBgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: GoogleFonts.libreBaskerville(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kBlack,
                  ),
                ),
                IconButton.outlined(
                  style: IconButton.styleFrom(
                    side: BorderSide(color: Color(0xffFFEDD5)),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xffAF5D48),
                    size: 20,
                  ),
                ),
              ],
            ),
            CustomSearchBar(
              hint: 'Search conversations',
              iconColor: Color(0xffC89D7C),
              hintColor: Color(0x99C89D7C),
            ),
            Expanded(
              child: BlocProvider(
                create: (context) =>
                    ConversationCubit(context.read<ChatRepository>())
                      ..fetchAllConversations(),

                child: BlocBuilder<ConversationCubit, ConversationState>(
                  builder: (context, state) {
                    final selectedConversationId = context
                        .read<ChatCubit>()
                        .currentConversationId;
                    if (state is ConversationLoaded) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              state.conversations[index].conversationId ==
                              selectedConversationId;
                          return ConversationListTile(
                            isSelected: isSelected,
                            title: state.conversations[index].title,
                            onTap: () {
                              context.read<ChatCubit>().fetchConversationById(
                                conversationId:
                                    state.conversations[index].conversationId,
                              );
                              Navigator.pop(context);
                            },
                            onDelete: () {
                              context
                                  .read<ConversationCubit>()
                                  .deleteConversation(
                                    conversationId: state
                                        .conversations[index]
                                        .conversationId,
                                  );
                            },
                          );
                        },
                        itemCount: state.conversations.length,
                      );
                    } else if (state is ConversationLoading) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: LoadingWidget(),
                      );
                    }
                    return Center(child: Text('No conversations found'));
                  },
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: 1,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: AppColors.kPlanPageBgColor,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.kBlack,
                    offset: Offset(0, -4),
                    blurRadius: 6.1,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
            ),
            CustomGradientButton(
              screenWidth: MediaQuery.of(context).size.width * 0.8,
              title: 'New Chat',
              onPressed: () {
                context.read<ChatCubit>().startNewConversation();
                Navigator.pop(context);
              },
              icon: Icons.add,
              topToBottom: false,
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xffFFF7ED)),
          ),
          child: Row(
            spacing: 10,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                width: 180,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
      itemCount: 5,
    );
  }
}

class ConversationListTile extends StatelessWidget {
  const ConversationListTile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
    required this.onDelete,
  });

  final bool isSelected;
  final String title;
  final void Function()? onTap;
  final void Function()? onDelete; // Callback triggered when delete is tapped

  @override
  Widget build(BuildContext context) {
    Offset tapPosition = Offset.zero;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTapDown: (details) {
          tapPosition = details.globalPosition;
        },
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffF6CB9E), Color(0xffFFF3E0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffFFEDD5)),
                )
              : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffFFF7ED)),
                ),
          child: ListTile(
            onLongPress: () async {
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;

              final String? selectedAction = await showMenu<String>(
                context: context,
                position: RelativeRect.fromRect(
                  Rect.fromLTWH(tapPosition.dx, tapPosition.dy, 50, 50),
                  Offset.zero & overlay.size,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                elevation: 4,
                items: [
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_outline,
                          color: AppColors.kPrimaryVariant,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Delete',
                          style: GoogleFonts.inter(
                            color: AppColors.kPrimaryVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              // If they click 'delete' from the popup menu, display the confirmation dialog
              if (selectedAction == 'delete' && context.mounted) {
                showDialog(
                  context: context,
                  builder: (dialogContext) => DeleteConfirmationDialog(
                    onConfirm: () {
                      if (onDelete != null) onDelete!();
                    }, title: 'Delete Chat?', content: 'Are you sure you want to delete this conversation?',
                  ),
                );
              }
            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            leading: Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffFDF1E5),
              ),
              child: SvgPicture.asset(
                AppConstants.messageIcon,
                colorFilter: ColorFilter.mode(
                  Color(0xffAF5D48),
                  BlendMode.srcIn,
                ),
              ),
            ),
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff43281C),
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

