import 'dart:io';

import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    this.fileExtension,
    required this.onPressed,
    required this.filePath,
  });
  final String? fileExtension;
  final String filePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: SizedBox(
        height: 35,
        width: 65,
        child: Stack(
          children: [
            Positioned.fill(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: fileExtension == 'jpg' || fileExtension == 'png'
                    ? Image.file(File(filePath), fit: BoxFit.cover)
                    : Center(
                        child: Text(
                          fileExtension!,
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: AppColors.kBlack),
                        ),
                      ),
              ),
            ),
            Positioned(
              right: 0,
              top: -2,
              child: SizedBox(
                height: 20,
                width: 20,
                child: GestureDetector(
                  onTap: onPressed,
                  child: Icon(
                    Icons.cancel_outlined,
                    color: AppColors.kPrimaryVariant,
                    size: 20,
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
