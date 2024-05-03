import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';

import '../model/add_task_model.dart';
import '../service/save_add_project.dart';
import 'menu_controller.dart';

class SaveProject  {
 static DateTimePicker dateTimePicker = Get.put(DateTimePicker());
 static ExpansionTileMenu menu = Get.put(ExpansionTileMenu());
static  void saveProject(String projectName,String description ) {

    if (projectName.isNotEmpty && description.isNotEmpty) {
      Tasks tasks = Tasks(
        taskGroup: menu.title.value,
        projectName: projectName,
        description: description,
        startDate:
        "${dateTimePicker.selectedDate.value}",
        endTime:
        "${dateTimePicker.selectedEndDate.value.day} ${DateFormat('MMMM').format(dateTimePicker.selectedEndDate.value)} , ${dateTimePicker.selectedEndDate.value.year} ",
      );
      Logger().e( DateTime.parse('2020-10-19 18:11:29.497022').runtimeType);
      SaveAddProject.storedProject(obj: tasks, objKey: DateTime.now().toString());
    }


  }
}