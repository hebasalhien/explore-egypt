import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  final ImagePicker picker = ImagePicker();
  /// Pick an image.
  Future<XFile?> pickImageFromGallery() async {
    return await picker.pickImage(source: ImageSource.gallery);
  }

  /// Capture a photo.
  Future<XFile?> capturePhoto() async {
    return await picker.pickImage(source: ImageSource.camera);
  }
  /// Pick multiple images.
  Future<List<XFile>?> pickMultipleImages() async {
    return await picker.pickMultiImage();
  }
}
