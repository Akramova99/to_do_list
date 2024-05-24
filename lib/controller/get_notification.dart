import 'package:get/get.dart';

class GetNotification extends GetxController {
  var getNotification = true.obs;

  void changeNotification() {
    getNotification.value = !getNotification.value;
  }
  }
