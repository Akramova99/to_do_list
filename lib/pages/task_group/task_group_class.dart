import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';

class TaskGroupClass {
  IconData iconOfTask;
  String typeTask;
  Color iconColor;
  double percentTask;
  int numberTask;

  TaskGroupClass({
    required this.iconOfTask,
    required this.typeTask,
    required this.iconColor,
    required this.percentTask,
    required this.numberTask,
  });
}

class TaskGroupList {
  static List<TaskGroupClass> taskProgressList = [
    TaskGroupClass(
        iconOfTask: IconlyBold.work,
        typeTask: "Office Project",
        iconColor: const Color(0xfff478b8),
        percentTask: 70,
        numberTask: 23),

    TaskGroupClass(
        iconOfTask: CupertinoIcons.profile_circled,
        typeTask: "Personal Project",
        iconColor: const Color(0xff5f33e1),
        percentTask: 75,
        numberTask: 23),
    TaskGroupClass(
        iconOfTask: CupertinoIcons.book_fill,
        typeTask: "Daily Study",
        iconColor: const Color(0xfff478b8),
        percentTask: 56,
        numberTask: 17),
    TaskGroupClass(
        iconOfTask: IconlyBold.bag_2,
        typeTask: "Office Project",
        iconColor: const Color(0xff5f33e1),
        percentTask: 45,
        numberTask: 30),
  ];
}
