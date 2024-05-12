import 'package:get/get.dart';
import 'package:to_do_list/controller/check_switch.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import 'package:to_do_list/service/hive_database.dart';
import 'package:to_do_list/service/notification_channel.dart';

import '../model/add_task_model.dart';
import '../service/flutter_toast.dart';
import 'menu_controller.dart';

class SaveProject extends GetxController {
  HiveService hiveService = Get.put(HiveService());
  IsSwitched isSwitched = Get.put(IsSwitched());
  var listTask = <Tasks>[].obs;
  DateTimePicker dateTimePicker = Get.put(DateTimePicker());
  ExpansionTileMenu menu = Get.put(ExpansionTileMenu());

  addProject(
      String projectName, String description, String objKey, bool isUpdate) {
    if (projectName.isNotEmpty && description.isNotEmpty) {
      Tasks tasks = Tasks(
          taskGroup: menu.title.value,
          projectName: projectName,
          description: description,
          startDate: dateTimePicker.selectedDate.value.toString(),
          endTime: dateTimePicker.selectedEndDate.value.toString(),
          stateOfTask: isSwitched.isSwitched.value ? "Done" : 'To do',
          key: objKey);
      hiveService.storedObj(obj: tasks, objKey: objKey);
      NotificationChannel.scheduleTaskNotification(tasks);
      isUpdate
          ? showToast("Update successfully")
          : showToast("Tasks saved successfully");
    }
    return isUpdate && projectName.isNotEmpty
        ? showToast("Update successfully")
        : null;
  }
}
