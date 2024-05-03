import 'package:get/get.dart';

class TaskGroupController extends GetxController {
  var selectedSection = 'Work'.obs(); // Default selected section
  void changeSection(String? newValue) {
    selectedSection = newValue!;
  }
}




