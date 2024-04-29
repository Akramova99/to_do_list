import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class TaskGroupController extends GetxController {
  var selectedSection = 'Work'.obs(); // Default selected section
  void changeSection(String? newValue) {
    selectedSection = newValue!;
  }
}




