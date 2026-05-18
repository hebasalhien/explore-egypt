import 'package:explore_egypt/core/media/file_picker_services.dart';
import 'package:explore_egypt/features/chat/presentation/views/widgets/menu_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomPopUpButton extends StatelessWidget{
  final List<PlatformFile> files;
  final ValueChanged<List<PlatformFile>> onFilesChanged;
  final ValueChanged<String>? onModeChanged;
  
  const CustomPopUpButton({
    super.key, 
    required this.files,
    required this.onFilesChanged, 
    this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
                  onSelected: (value) async{
                    if (value == 'uploadFile') {
                      try {
                        final pickedFiles =
                            await FilePickerServices.pickFiles();
                        if (pickedFiles != null) {
                          final updatedFiles = List<PlatformFile>.from(files)
                            ..addAll(pickedFiles);
                          onFilesChanged(updatedFiles);
                        }
                      } on Exception catch (e) {
                        debugPrint("exception was cought: ${e.toString()}");
                      }
                    } else if (value == 'planMode') {
                      onModeChanged?.call('plan');
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<String>>[
                        PopupMenuItem(
                          value: 'uploadFile',
                          child: MenuItem(
                            text: 'Upload File',
                            iconData: Icons.attach_file,
                          ),
                        ),
                        PopupMenuItem(
                          value: 'planMode',
                          child: MenuItem(
                            text: 'Plan Mode',
                            iconData: Icons.map_outlined,
                          ),
                        ),
                      ],
                  color: Colors.white,
                  offset: const Offset(0, -115),
                  position: PopupMenuPosition.over,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                  child: Icon(Icons.add),
    );
  }
}