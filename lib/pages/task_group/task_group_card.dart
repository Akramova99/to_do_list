import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_do_list/controller/percent_of_tasks.dart';
import 'package:to_do_list/pages/task_group/task_group_class.dart';

class TaskGroupCard extends StatelessWidget {
  final TaskGroupClass taskGroupClass;

  const TaskGroupCard({super.key, required this.taskGroupClass});

  @override
  Widget build(BuildContext context) {
    Percent percent = Get.put(Percent());
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: taskGroupClass.iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Icon(
                  taskGroupClass.iconOfTask,
                  size: 24,
                  color: taskGroupClass.iconColor,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskGroupClass.typeTask,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              if (percent.officeTaskCount().value == 0)
                const Text(
                  "here the number of tasks is visible",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              if (percent.officeTaskCount().value != 0)
                Obx(() => Text(
                      "${taskGroupClass.typeTask == "Office Project" ? percent.officeTaskCount() : (taskGroupClass.typeTask == "Personal Project" ? percent.personalTaskCount() : percent.dailyStudyCount())} tasks",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    )),
            ],
          ),
          Expanded(child: Container()),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: CircularPercentIndicator(
              startAngle: 120,
              radius: 25.0,
              lineWidth: 5.0,
              animation: true,
              percent: taskGroupClass.typeTask == "Office Project"
                  ? percent.officeTaskPercent().ceilToDouble() / 100
                  : (taskGroupClass.typeTask == "Personal Project"
                      ? percent.personalTaskPercent().ceilToDouble() / 100
                      : percent.dailyStudyPercent().ceilToDouble() / 100),
              center: Obx(() => Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                        color: Colors.black),
                    "${taskGroupClass.typeTask == "Office Project" ? percent.officeTaskPercent().ceilToDouble() : (taskGroupClass.typeTask == "Personal Project" ? percent.personalTaskPercent().ceilToDouble() : percent.dailyStudyPercent().ceilToDouble())}%",
                  )),
              backgroundColor:taskGroupClass.typeTask == "Personal Project"?Colors.deepPurple.shade100: Colors.pink.shade50,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor:taskGroupClass.typeTask == "Personal Project"?Colors.deepPurple: Colors.pink.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
