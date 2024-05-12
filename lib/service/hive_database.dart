import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/model/add_task_model.dart';

import 'flutter_toast.dart';

class HiveService extends GetxController {
  var objBox = Hive.box('Tasks');
  var tasksList = <Tasks>[].obs;

  ///Hive yordamida obj saqlash :date time now orqali key berish
  storedObj({required var obj, required String objKey}) {
    String stringUserObj = jsonEncode(obj);
    objBox.put(objKey, stringUserObj);
    Logger().i("user info saved successfully");
    return showToast("Tasks saved successfully");
  }

  ///Hamma Tasks objni olish funksiyasi
  List<Tasks> getObj() {
    tasksList.clear();
    for (var key in objBox.keys) {
      String stringObj = objBox.get(key);

      Map<String, dynamic> map = jsonDecode(stringObj);
      Tasks task = Tasks.fromJson(map);
      tasksList.add(task);
    }

    return tasksList;
  }

  deleteObj({required String objKey}) {
    objBox.delete(objKey);
    return showToast("deleted successfully");
  }
}
