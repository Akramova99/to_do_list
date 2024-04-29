
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class ExpansionTileMenu extends GetxController {
  var title = "Work".obs;
  var iconData = IconlyBold.work.obs;
  var colorIcon = const Color(0xfff478b8).obs;
  var customIcon = false.obs;

  void changeIcon(bool expanded) {
    customIcon.value = expanded;
  }
  void changeText(String newValue) {
    title.value = newValue;
  }
  void changeIconData( IconData newLeading) {
    iconData.value = newLeading;
  }

  void changeTitle(String newValue, Color newColor, IconData newLeading) {
    title.value = newValue;
    colorIcon.value = newColor;
    iconData.value = newLeading;
  }
}