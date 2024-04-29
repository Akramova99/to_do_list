import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../service/save_add_project.dart';

class GetTasks extends GetxController{
  var item = [].obs;
  void addTask()async{
   item.value=await SaveAddProject.getTasks();
   Logger().i(item[0]);
  }

}