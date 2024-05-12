import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import 'package:to_do_list/service/flutter_toast.dart';
import 'package:to_do_list/service/hive_database.dart';

import '../model/add_task_model.dart';
import 'menu_controller.dart';

class SaveProject extends GetxController {
  HiveService hiveService = Get.put(HiveService());
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
        endTime: dateTimePicker.selectedEndDate.value.toString(), stateOfTask: 'To do',
      );
     hiveService.storedObj(obj: tasks, objKey: DateTime.now().toString());


      Logger().w(tasks.startDate);
    }
  }
}
