import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

import 'flutter_toast.dart';

class HiveService {
  Future<Box<List>> box() {
    var box = Hive.openBox<List>("KeyTasks");
    return box;
  }

  // key = dd/MM/yyyy
  //Add
  void storeTasks(List newList, var id) async {
    var myBox = await box();
    myBox.put(id, newList);
  }

//Get
  Future<List> getTasks(var id) async {
    var myBox = await box();
    List list = [];
    for (var taskKey in myBox.keys) {
      String key = taskKey.toString().substring(0, 10);
      Logger().e(key);

      if (key == id) {
        list.addAll(myBox.get(taskKey)??[]);
      }
    }
    return list;
  }
   deleteProject() async {
    var myBox = await box();

    for (var objKey in myBox.keys) {
      myBox.delete(objKey);
    }
    return showToast("deleted successfully");
  }
}
