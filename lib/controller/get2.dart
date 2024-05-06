import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../model/add_task_model.dart';
import '../service/hive_database.dart';

class Get2 extends GetxController {
  List<Tasks> projects = <Tasks>[].obs;
  HiveService hiveService = HiveService();

  getSavedTasks(String key) async {
    for (var item in await hiveService.getTasks(key)) {
      projects.add(item);
    }
  }

  void dateTask(DateTime selectedDate) {
    String key =selectedDate.toString().substring(0,10);
    Logger().w(key);
    projects.clear();
    getSavedTasks(key);
  }
}
