import 'package:get/get.dart';
import 'package:to_do_list/service/hive_database.dart';

class Percent extends GetxController {
  static HiveService get2 = Get.put(HiveService());
  static double calculatePercent() {
    if (get2.tasksList.isEmpty) {
      return 0; // No tasks, so percentage is 0
    }
    return 100 * get2.doneTasks.length / get2.tasksList.length;
  }

  static var percentView = 0.0.obs;

  static void updatePercentView() {
    percentView.value = calculatePercent();
  }
 static var check = get2.allTasks.length;

}
