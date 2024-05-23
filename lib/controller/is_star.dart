import 'package:get/get.dart';

class IsStar extends GetxController {

  var isStar = false.obs;

  void changeStar(bool newStar) {
    isStar.value = newStar;
  }
}
