import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';

class TaskGroupClass {
  IconData iconOfTask;
  String typeTask;
  Color iconColor;


  TaskGroupClass({
    required this.iconOfTask,
    required this.typeTask,
    required this.iconColor,

  });
}

class TaskGroupList {
  static List<TaskGroupClass> taskProgressList = [
    TaskGroupClass(
        iconOfTask: IconlyBold.work,
        typeTask: "Office Project",
        iconColor: const Color(0xfff478b8),),
    TaskGroupClass(
        iconOfTask: CupertinoIcons.profile_circled,
        typeTask: "Personal Project",
        iconColor: const Color(0xff5f33e1),
     ),
    TaskGroupClass(
        iconOfTask: CupertinoIcons.book_fill,
        typeTask: "Daily Study",
        iconColor: const Color(0xfff478b8),
        ),
   ];
}
