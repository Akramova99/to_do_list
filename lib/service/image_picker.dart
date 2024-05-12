
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<XFile?> pickImagefromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  static Future<XFile?> pickImagefromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    return image;
  }
}
