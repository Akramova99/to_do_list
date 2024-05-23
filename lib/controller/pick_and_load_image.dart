import 'dart:io';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

import '../service/image_picker.dart';
import '../service/store_image.dart';

class ImageController extends GetxController {
  var image = Rx<File?>(_getInitialFile());

  @override
  void onInit() {
    super.onInit();
    _initializeImage();
  }

  Future<void> _initializeImage() async {

    image.value = await getImageFileFromAssets('images/girl1.png');
  }

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

  static File _getInitialFile() {
    // Return a temporary file synchronously as a placeholder
    // This file should exist to avoid issues
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/temp.png');
    tempFile.createSync(); // Ensure the file is created
    return tempFile;
  }
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');
  final buffer = byteData.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = '${tempDir.path}/temp.png';
  await File(tempPath).writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  return File(tempPath);
}