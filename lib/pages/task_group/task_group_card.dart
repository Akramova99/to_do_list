import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_do_list/pages/task_group/task_group_class.dart';
class TaskGroupCard extends StatelessWidget {
  final TaskGroupClass taskGroupClass;
  const TaskGroupCard({super.key,required this.taskGroupClass});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
              Text(
                "${taskGroupClass.numberTask} tasks",
                style:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Expanded(child: Container()),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.transparent,
            child: CircularPercentIndicator(
              // fillColor: Colors.red,
              startAngle: 120,
              radius: 25.0,
              lineWidth: 5.0,
              animation: true,
              percent: 0.7,
              center: Text(
                "${taskGroupClass.percentTask}%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Colors.black),
              ),
              backgroundColor: Colors.pink.shade50,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.pink.shade200,
            ),
          ),
        ],
      ),
    );
  }
}

