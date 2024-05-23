import 'package:get/get.dart';

class IsBadgeVisible extends GetxController{
  var isVisible = false.obs;

  void changeBadge(bool badge) {
    isVisible.value = badge;
  }
}