import 'package:get/get.dart';
import 'package:to_do_list/controller/check_switch.dart';
import 'package:to_do_list/controller/get_notification.dart';
import 'package:to_do_list/controller/is_badge_visible.dart';
import 'package:to_do_list/controller/is_star.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import 'package:to_do_list/service/hive_database.dart';
import 'package:to_do_list/service/notification_channel.dart';

import '../model/add_task_model.dart';
import '../service/flutter_toast.dart';
import 'menu_controller.dart';

class SaveProject extends GetxController {
  HiveService hiveService = Get.put(HiveService());
  IsSwitched isSwitched = Get.put(IsSwitched());
  IsStar isStar = Get.put(IsStar());
  DateTimePicker dateTimePicker = Get.put(DateTimePicker());
  ExpansionTileMenu menu = Get.put(ExpansionTileMenu());
  GetNotification note = Get.put(GetNotification());
  IsBadgeVisible visible = Get.put(IsBadgeVisible());

  addProject(String projectName, String description, String objKey) {
    if (projectName.isNotEmpty && description.isNotEmpty) {
      Tasks tasks = Tasks(
          taskGroup: menu.title.value,
          projectName: projectName,
          description: description,
          startDate: dateTimePicker.selectedDate.value.toString(),
          endTime: dateTimePicker.selectedEndDate.value.toString(),
          stateOfTask: isSwitched.isSwitched.value ? "Done" : 'To do',
          key: objKey,
          star: isStar.isStar.value);
      hiveService.storedObj(obj: tasks, objKey: objKey);
      visible.changeBadge(true);
      NotificationChannel.scheduleTaskNotification(
          tasks, note.getNotification.value);
      showToast("Tasks saved successfully");
    }
  }

  updateProject(String projectName, String description, String objKey,
      String type, bool isUpdate) {
    if (projectName.isNotEmpty && description.isNotEmpty) {
      Tasks tasks = Tasks(
          taskGroup: type,
          projectName: projectName,
          description: description,
          startDate: dateTimePicker.selectedDate.value.toString(),
          endTime: dateTimePicker.selectedEndDate.value.toString(),
          stateOfTask: isSwitched.isSwitched.value ? "Done" : 'To do',
          key: objKey,
          star: isStar.isStar.value);
      hiveService.storedObj(obj: tasks, objKey: objKey);
      // NotificationChannel.scheduleTaskNotification(tasks, note.getNotification.value);
      isUpdate ? showToast("Update successfully") : null;
    }
  }
}
