import 'package:get/get.dart';

class DoneTaskText extends GetxController {
  var doneTaskText = false.obs;

  void changeText() {
    doneTaskText.value = !doneTaskText.value;
  }
}
