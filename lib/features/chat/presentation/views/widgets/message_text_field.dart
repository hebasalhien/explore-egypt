import 'package:explore_egypt/core/media/file_picker_services.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/attachment_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    super.key,
    required this.controller,
    required this.files,
    required this.onFilesChanged,
  });

  final TextEditingController controller;
  final List<PlatformFile> files;
  final ValueChanged<List<PlatformFile>> onFilesChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 64,
              spreadRadius: -4,
              offset: Offset(0, 14),
              color: AppColors.kShadowColor.withAlpha(31),
            ),
            BoxShadow(
              blurRadius: 22,
              spreadRadius: -6,
              offset: Offset(0, 8),
              color: AppColors.kShadowColor.withAlpha(31),
            ),
          ],
        ),
        child: Column(
          children: [
            if (files.isNotEmpty)
              SizedBox(
                height: 85,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    return AttachmentCard(
                      onPressed: () {
                        final updatedFiles = List<PlatformFile>.from(files)..removeAt(index);
                        onFilesChanged(updatedFiles);
                      },
                      filePath: file.path.toString(),
                      fileExtension: file.extension,
                    );
                  },
                ),
              ),
            TextField(
              controller: controller,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              cursorColor: const Color.from(
                alpha: 1,
                red: 0.89,
                green: 0.639,
                blue: 0.4,
              ),
              decoration: InputDecoration(
                hintText: 'Generate a name of ...',
                contentPadding: EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.mic_none),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom:10.0,left: 10),
                  child: IconButton(
                    onPressed: () async {
                      try {
                        final pickedFiles = await FilePickerServices.pickFiles();
                        if (pickedFiles != null) {
                          final updatedFiles = List<PlatformFile>.from(files)..addAll(pickedFiles);
                          onFilesChanged(updatedFiles);
                        } 
                      } on Exception catch (e) {
                        debugPrint("exception was cought: ${e.toString()}");
                      }
                    },
                    icon: Icon(Icons.attach_file),
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
