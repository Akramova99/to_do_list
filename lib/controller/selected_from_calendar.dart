import 'package:get/get.dart';

class SelectedFromCalendar extends GetxController{
  var mySelectedDate = DateTime.now().obs;
  void changeSelectedDate (DateTime selectedDate){
    mySelectedDate.value=selectedDate;
  }
}