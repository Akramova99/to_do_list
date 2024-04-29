import 'package:get/get.dart';

class DateTimePicker extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedEndDate = DateTime.now().obs;

  void changeDate(DateTime dateTime) {
    selectedDate.value = dateTime;
  }

  void changeEndDate(DateTime dateTime) {
    selectedEndDate.value = dateTime;
  }
  void makeInitial() {
    selectedDate.value = DateTime.now();
    selectedEndDate.value = DateTime.now();
  }

}