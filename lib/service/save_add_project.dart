import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/model/add_task_model.dart';

import 'flutter_toast.dart';

class SaveAddProject {
  static var projectBox = Hive.box('addProject');

//Hive yordamida [AddProject] loyihasini model class bilan strored qilish.
// Unda aniq bir objectni stored qilish mumkin bo'lmagani uchun avval
//AddProject objectini o'zinig keyi bilan stringga o'tkazib so'ngra
// Hive bn ochgan boxda saqlab qoyadi.
  // Using Hive to make the [AddProject] project stored with model class.
// Since it is not possible to store a specific object in it, first
// Skip AddProject object to string with the key then
// Hive bn saves in the box you opened.
  static storedProject({required var obj, required String objKey}) {
    String stringUserObj = jsonEncode(obj);
    projectBox.put(objKey, stringUserObj);
    Logger().i("user info saved successfully");
    return showToast("user info saved successfully");
  }

  //Hive bilan telefonda saqlab qoyilgan ma'lumotlarni yana qayta olib ishlatish
  //munkin bo'ladi.Uni esa o'sha qutidan keyi bilan string holida olamiz va
  //jsonDecode bn map ko'rinishidan modeldagi fromJsondan yana object holatiga keltirdik.
  // Use the saved data on the phone with Hive to re-bring it again
  // will be do.And we get it from the same box with the next in the string case and
  //from jsonDecode bn map view from fromJson in the model we have again made it to object state.

  static Tasks getProject({required String objKey}) {
    String stringObj = projectBox.get(objKey);

    Map<String, dynamic> map = jsonDecode(stringObj);
    Tasks user = Tasks.fromJson(map);
    return user;
  }

  // albatta uni o'chirib ham tashlash mumkin. Bu esa o'sha box orqali amalga oshiriladi.
  // of course it can also be deleted. This is done through that box.
  static Future<List<Tasks>> getTasks() async {
    List<Tasks> tasks = [];
    for (var objKey in projectBox.keys) {
      String stringObj = projectBox.get(objKey);
      Map<String, dynamic> map = jsonDecode(stringObj);
      Tasks userTasks = Tasks.fromJson(map);

      tasks.add(userTasks);
      Logger().i(userTasks.description);
    }
    return tasks;
  }

  static List<Tasks> parsingResponse(String response) {
    dynamic json = jsonDecode(response);
    List<Tasks> tasksList = List.from(json.map((task) => Tasks.fromJson(task)));
    return tasksList;
  }

  static deleteProject({required String objKey}) {
    projectBox.delete(objKey);
    return showToast("deleted successfully");
  }
}
