import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../model/add_task_model.dart';
import '../service/hive_database.dart';

class Get2 extends GetxController {
  List<Tasks> projects = <Tasks>[].obs;
  HiveService hiveService = HiveService();

  getSavedTasks(String key) async {
    try {
      var tasks ;
      if (tasks != null) {
        for (var item in tasks) {
          projects.add(item);
        }
      } else {
        Logger().i('No tasks found for the provided key.');
      }
    } catch (e) {
      Logger().e('An error occurred while retrieving tasks: $e');
    }
  }

  void dateTask(DateTime selectedDate) {
    String key =selectedDate.toString().substring(0,10);
    //2024-05-09
    //2024-05-09
    //2024-05-09
    Logger().w(key);
    projects.clear();
    getSavedTasks(key);
  }
}
