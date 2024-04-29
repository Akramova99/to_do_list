// import 'dart:convert';
//
// import 'package:hive/hive.dart';
// import 'package:logger/logger.dart';
// import 'package:to_do_list/model/add_task_model.dart';
// import 'package:to_do_list/service/flutter_toast.dart';
//
//
// class SaveAddProject {
//   static var projectBox = Hive.box('addProject');
//
//
//   // Using Hive to make the [AddProject] project stored with model class.
// // Since it is not possible to store a specific object in it, first
// // Skip AddProject object to string with the key then
// // Hive bn saves in the box you opened.
//   static storedProject({required var obj, required String objKey}) {
//     String stringUserObj = jsonEncode(obj);
//     projectBox.put(objKey, stringUserObj);
//     Logger().i("user info saved successfully");
//     return showToast("user info saved successfully");
//   }
//
//
//   // Use the saved data on the phone with Hive to re-bring it again
//   // will be do.And we get it from the same box with the next in the string case and
//   //from jsonDecode bn map view from fromJson in the model we have again made it to object state.
//
//   static Tasks getProject({required String objKey}) {
//     String stringObj = projectBox.get(objKey);
//
//     Map<String, dynamic> map = jsonDecode(stringObj);
//     Tasks user = Tasks.fromJson(map);
//     return user;
//   }
//
//   static Future<List<Tasks>> getTasks() async {
//     final box = await Hive.openBox<Tasks>('tasks');
//     List<Tasks> tasks = [];
//     for (var key in box.keys) {
//       tasks.add(box.get(key)!);
//       Logger().i(tasks);
//     }
//     return tasks;
//   }
//   static deleteProject({required String objKey}) {
//     projectBox.delete(objKey);
//     return showToast("deleted successfully");
//   }
// // of course it can also be deleted. This is done through that box.
// }
//SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 dailyStudy("9:00 PM"),
//                                 officeProject("10:00 AM", "done", title4,
//                                     "Market Research"),
//                                 officeProject("8:00 AM", "In Progress", title4,
//                                     "Market Research"),
//                                 dailyStudy("2:00 PM"),
//                                 profileProject("9:00 PM"),
//                                 SizedBox(
//                                   height: 200,
//                                 )
//                               ],
//                             ),
//                           ),
//                           SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 officeProject("10:00 AM", "done", title4,
//                                     "Market Research"),
//                                 officeProject("8:00 AM", "In Progress", title4,
//                                     "Market Research"),
//                                 dailyStudy("9:00 PM"),
//                               ],
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               officeProject("8:00 AM", "In Progress", title4,
//                                   "Market Research"),
//                               Expanded(child: Container())
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               profileProject("9:00 PM"),
//                               profileProject("9:00 PM"),
//                               Expanded(child: Container())
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               officeProject("10:00 AM", "done", title4,
//                                   "Market Research"),
//                               Expanded(child: Container())
//                             ],
//                           )
