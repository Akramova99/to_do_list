import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart'; // Add this import to handle date formatting
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';

import '../model/add_task_model.dart';
import '../service/save_add_project.dart';

class ShowIcons2 extends GetxController {
  DateTimePicker picker =Get.put(DateTimePicker());
  var showIcon = IconlyBold.arrow_down_2.obs;
  var showList = <Tasks>[].obs;
  Rx<DateTime> mySelectedDate = DateTime.now().obs;
  void changeSelectedDate (DateTime selectedDate){
    mySelectedDate.value=selectedDate;
  }


  // Refresh icon and list based on the selected date
  Future<void> iconChange() async {
    List<Tasks> tasks = await SaveAddProject.getTasks();
    // Clear the current list to refill it based on the new date
    showList.clear();
    for (var task in tasks) {
      Logger().d( mySelectedDate.value);
      Logger().d(task.startDate!);
      // Check if task's startTime is on the selected date
      if (isSameDate(DateTime.parse(task.startDate!), mySelectedDate.value)) {
        // Update icon based on the task group
        updateIconBasedOnGroup(task);
        showList.add(task);
      }
    }
  }

  void updateIconBasedOnGroup(Tasks task) {
    switch (task.taskGroup) {
      case "Daily Study":
        showIcon.value = CupertinoIcons.book_fill;
        break;
      case "Work":
        showIcon.value = IconlyBold.work;
        break;
      case "Profile":
        showIcon.value = CupertinoIcons.profile_circled;
        break;
      default:
        showIcon.value = IconlyBold.home;
        break;
    }
  }



  // Helper function to check if two dates are the same
  bool isSameDate(DateTime date1, DateTime date2) {
    return DateFormat('yyyy-MM-dd').format(date1) ==
        DateFormat('yyyy-MM-dd').format(date2);
  }
}