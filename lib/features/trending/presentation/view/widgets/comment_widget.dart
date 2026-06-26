import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/trending/model/entities/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.commentModel});

  final CommentModel commentModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x40FFFFFF), // #FFFFFF40
            offset: Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 0.0,
          ),

          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            offset: Offset(0, 3),
            blurRadius: 2.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(commentModel.userImage),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 100,
                children: [
                  Text(
                    commentModel.userName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.kBlack,
                    ),
                  ),
                  Text(
                    timeago.format(commentModel.createdAt),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textCaption,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Generate the stars dynamically
                  ...List.generate(5, (index) {
                    if (index < commentModel.rating.floor()) {
                      // Full Star
                      return const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFE3A366),
                        size: 16,
                      );
                    } else if (index < commentModel.rating &&
                        commentModel.rating % 1 != 0) {
                      // Half Star (for values like 4.5)
                      return const Icon(
                        Icons.star_half_rounded,
                        color: Color(0xFFE3A366),
                        size: 16,
                      );
                    } else {
                      // Empty Border Star
                      return Icon(
                        Icons.star_border_rounded,
                        color: Colors.grey[300],
                        size: 16,
                      );
                    }
                  }),
                ],
              ),
              Expanded(
                child: Text(
                  commentModel.comment,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textCaption,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
