
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxString name = "Name".obs;

  void saveName(String newName) {
    name.value= newName;
  }
}
