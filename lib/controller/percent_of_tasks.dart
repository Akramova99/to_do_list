import 'package:get/get.dart';
import 'package:to_do_list/service/hive_database.dart';

class Percent extends GetxController {
   HiveService get2 = Get.put(HiveService());

   double calculatePercent() {
    if (get2.tasksList.isEmpty) {
      return 0; // No tasks, so percentage is 0
    }
    return 100 * get2.doneTasks.length / get2.tasksList.length;
  }

   var percentView = 0.0.obs;

   RxInt check() => get2.allTasks.length.obs;

//Count of office project tasks
   RxInt officeTaskCount() =>get2.officeProject.length.obs;

//Count of Personal project tasks
   RxInt personalTaskCount() => get2.personalProject.length.obs;

//Count of Daily Study tasks
   RxInt dailyStudyCount() => get2.dailyStudy.length.obs;

//Percent of office project tasks
   RxDouble officeTaskPercent() =>get2.officeProjectDone.isNotEmpty?
      (100 * get2.officeProjectDone.length / officeTaskCount().value).obs:0.0.obs;

//Percent of Personal project tasks
   RxDouble personalTaskPercent() =>get2.personalProjectDone.isNotEmpty?
      (100 * get2.personalProjectDone.length / personalTaskCount().value).obs:0.0.obs;

//Percent of Daily Study tasks
   RxDouble dailyStudyPercent() =>get2.dailyStudyDone.isNotEmpty?
      (100 * get2.dailyStudyDone.length / dailyStudyCount().value).obs:0.0.obs;

   void updatePercentView() {
    percentView.value = calculatePercent();

  }
}
