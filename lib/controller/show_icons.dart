import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/selected_from_calendar.dart';

import '../model/add_task_model.dart';
import '../service/save_add_project.dart';

class ShowIcons extends GetxController {
  SelectedFromCalendar calendar = Get.put(SelectedFromCalendar());

  var showIcon = IconlyBold.arrow_down_2.obs;
  var showList = [].obs;

  Future<void> iconChange() async {
    List<Tasks> tasks = await SaveAddProject.getTasks();

    for (var task in tasks) {
      if (task.taskGroup == "Daily Study") {
        showIcon.value = CupertinoIcons.book_fill;
        Logger().e(task.taskGroup);

        showList.add(task);
      } else if (task.taskGroup == "Work") {
        showIcon.value = IconlyBold.work;
        Logger().e(task.taskGroup);
        showList.add(task);
      } else if (task.taskGroup == "Profile") {
        showIcon.value = CupertinoIcons.profile_circled;
        Logger().e(task.taskGroup);

        showList.add(task);
      }
    }
  }
}




