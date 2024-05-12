import 'dart:io';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../service/image_picker.dart';
import '../service/store_image.dart';

class ImageController extends GetxController {
  var image = Rx<File?>(null);

  void pickImage() {
    ImagePickerService.pickImagefromGallery().then((_image) {
      if (_image != null) {
        final path = _image.path;
        DatabaseHelper().insertImage(path).then((id) {
          image.value = File(path);
        });
      }
    });
  }

  void loadImage() async {
    String? imagePath = await DatabaseHelper().getImage();
    if (imagePath != null) {
      image.value = File(imagePath);
      Logger().i(imagePath);
    }
  }
}
