import 'package:file_picker/file_picker.dart';

class FilePickerServices {
  static Future<dynamic> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withReadStream: true
    );
    if (result != null) {
      return result.files;
    } else {
      return null;
    }
  }
}
