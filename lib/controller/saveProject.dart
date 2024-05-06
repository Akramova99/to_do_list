import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import 'package:to_do_list/service/flutter_toast.dart';
import 'package:to_do_list/service/hive_database.dart';

import '../model/add_task_model.dart';
import 'menu_controller.dart';

class SaveProject extends GetxController {
  HiveService hiveService = HiveService();
  var listTask = <Tasks>[].obs;
  DateTimePicker dateTimePicker = Get.put(DateTimePicker());
  ExpansionTileMenu menu = Get.put(ExpansionTileMenu());

  void addProject(String projectName, String description) {
    if (projectName.isNotEmpty && description.isNotEmpty) {
      Tasks tasks = Tasks(
        taskGroup: menu.title.value,
        projectName: projectName,
        description: description,
        startDate: dateTimePicker.selectedDate.value.toString(),
        endTime: dateTimePicker.selectedEndDate.value.toString(),
      );
      listTask.add(tasks);

      Logger().w(tasks.startDate);
    }
  }

  void storeProject(String projectName, String description) async {
    String key =  dateTimePicker.selectedDate.value.toString();
    RxList<Tasks> lst = <Tasks>[].obs;
    if (await hiveService.getTasks(key) == null) {
      addProject(projectName, description);
      hiveService.storeTasks(listTask, key);
      showToast("Stored Not Successfully");
      Future.delayed(Duration.zero);
    } else {
      for (Tasks item in await hiveService.getTasks(key)) {
        lst.add(item);
      }
      addProject(projectName, description);
      lst.add(listTask.first);
      hiveService.storeTasks(lst, key);
      Logger().i(key);
      Logger().e(key.runtimeType);
      showToast("Stored Successfully");


    }
  }
}
