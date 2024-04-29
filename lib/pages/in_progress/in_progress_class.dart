import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';

import '../../string_text.dart';

class InProgressClass {
  IconData? iconOfTask;
  String? typeTask;
  String? taskName;
  Color? colorCard;
  Color? iconColor;
  double? percentTask;

  InProgressClass({
    required this.iconOfTask,
    required this.typeTask,
    required this.taskName,
    required this.colorCard,
    required this.iconColor,
    required this.percentTask,
  });
}

class InProgressList {
 static List<InProgressClass> inProgressList = [
    InProgressClass(
        iconOfTask: IconlyBold.work,
        typeTask: "Office Project",
        taskName: title4,
        colorCard: const Color(0xffe7f3ff),
        iconColor: const Color(0xfff478b8),
        percentTask: 78),
    InProgressClass(
        iconOfTask:CupertinoIcons.profile_circled,
        typeTask: "Personal Project",
        taskName: title5,
        colorCard: const Color(0xffffe9e1),
        iconColor: const Color(0xff5f33e1),
        percentTask: 60),
    InProgressClass(
        iconOfTask: CupertinoIcons.book_fill,
        typeTask: "Daily Study",
        taskName: "Learning English, listening, writing, reading",
        colorCard: const Color(0xffede4ff),
        iconColor: const Color(0xffff9142),
        percentTask: 80),
    InProgressClass(
        iconOfTask: IconlyBold.work,
        typeTask: "Office Project",
        taskName: title4,
        colorCard: const Color(0xffe7f3ff),
        iconColor: const Color(0xfff478b8),
        percentTask: 80),
    InProgressClass(
        iconOfTask: IconlyBold.work,
        typeTask: "Health",
        taskName: title7,
        colorCard: const Color(0xffe7f3ff),
        iconColor: const Color(0xfff478b8),
        percentTask: 80),
    InProgressClass(
        iconOfTask: IconlyBold.work,
        typeTask: "Office Project",
        taskName: title8,
        colorCard: const Color(0xffe7f3ff),
        iconColor: const Color(0xfff478b8),
        percentTask: 80),
  ];
}
