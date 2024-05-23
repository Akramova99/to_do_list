import 'package:get/get.dart';

class GetNotification extends GetxController {
  var getNotification = false.obs;

  void changeNotification() {
    getNotification.value = !getNotification.value;
  }
  }
