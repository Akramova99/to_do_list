import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/check_switch.dart';
import 'package:to_do_list/model/add_task_model.dart';

import 'flutter_toast.dart';

class HiveService extends GetxController {
  IsSwitched selectedFromCalendar = Get.put(IsSwitched());
  var myBox = Hive.box('profile');

  var objBox = Hive.box('Tasks');
  var tasksList = <Tasks>[].obs;
  var allTasks = <Tasks>[].obs;

  ///Hive yordamida obj saqlash :date time now orqali key berish
  storedObj({required var obj, required String objKey}) {
    String stringUserObj = jsonEncode(obj);
    objBox.put(objKey, stringUserObj);
    Logger().i("user info saved successfully");
  }

  ///Hamma Tasks objni olish funksiyasi
  List<Tasks> getObj() {
    tasksList.clear();
    allTasks.clear();
    for (var key in objBox.keys) {
      String stringObj = objBox.get(key);
      Map<String, dynamic> map = jsonDecode(stringObj);
      Tasks task = Tasks.fromJson(map);
      tasksList.add(task);
      allTasks.add(task);
    }

    return tasksList;
  }

  void getTasksForSelectedDate(DateTime date) {
    var allTasks = getObj(); // This fetches all tasks from Hive
    tasksList.value = allTasks.where((task) {
      DateTime startDate = DateTime.parse(task.startDate!);
      // Assuming 'startDate' is stored as a string in ISO format
      return startDate.year == date.year &&
          startDate.month == date.month &&
          startDate.day == date.day;
    }).toList();
    tasksList.value = tasksList.reversed.toList(); // Reverse the filtered list
  }

  // Method to filter "To Do" tasks
  List<Tasks> get toDoTasks =>
      tasksList.where((task) => task.stateOfTask == 'To do').toList();

  // Method to filter "Done" tasks
  List<Tasks> get doneTasks =>
      tasksList.where((task) => task.stateOfTask == 'Done').toList();

//New list office project
  List<Tasks> get officeProject {
    RxList<Tasks> doneList = allTasks;
    return doneList.where((task) => task.taskGroup == 'Work').toList();
  }

  List<Tasks> get officeProjectDone =>
      officeProject.where((task) => task.stateOfTask == 'Done').toList();

//New list personal project

  List<Tasks> get personalProject {
    RxList<Tasks> personalList = allTasks;

    return personalList.where((task) => task.taskGroup == 'Profile').toList();
  }

  List<Tasks> get personalProjectDone =>
      personalProject.where((task) => task.stateOfTask == 'Done').toList();

//New list daily study

  List<Tasks> get dailyStudy {
    RxList<Tasks> dailyList = allTasks;

    return dailyList.where((task) => task.taskGroup == 'Daily Study').toList();
  }

  List<Tasks> get dailyStudyDone =>
      dailyStudy.where((task) => task.stateOfTask == 'Done').toList();

  deleteObj({required String objKey}) {
    objBox.delete(objKey);
    return showToast("deleted successfully");
  }

  storeProfile({required String name}) {
    myBox.put("name", name);
  }

  getProfile() {
    var getName = myBox.get("name");
    return getName;
  }
}
