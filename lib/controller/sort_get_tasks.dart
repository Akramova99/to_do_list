import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../model/add_task_model.dart';
import '../service/save_add_project.dart';

class SortGetTasks extends GetxController {
  var inProgress = [].obs;
  var toDo = [].obs;
  var done = [].obs;

  void sumInProgress() async {
    List<Tasks> tasks = await SaveAddProject.getTasks();
    for (var task in tasks) {
      if (task.taskGroup == "Work") {
        inProgress.add(task);
        Logger().e("${task.taskGroup}--------Work");

      }
      Logger().i("${task.taskGroup}--------Work");
    }
  }

  void sumToDo() async {
    List<Tasks> tasks = await SaveAddProject.getTasks();
    for (var task in tasks) {
      if (task.taskGroup == "Daily Study") {
        toDo.add(task);
        Logger().e("${task.taskGroup}-----------sumToDo");

      }
      Logger().i("${task.taskGroup}-----------sumToDo");
    }
  }

  void sumDone() async {
    List<Tasks> tasks = await SaveAddProject.getTasks();
    for (var task in tasks) {
      if (task.taskGroup == "Profile") {
        done.add(task);
        Logger().e("${task.taskGroup}-------sumDone");

      }
      Logger().i("${task.taskGroup}-------sumDone");

    }
  }
}
