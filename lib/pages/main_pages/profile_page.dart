import 'dart:ui';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';

import '../../controller/get_tasks.dart';
import '../../model/add_task_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTimePicker timePicker = Get.put(DateTimePicker());
    GetTasks tasks = Get.put(GetTasks());
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/img_1.png"))),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white60, Colors.white]),
                ),
              ),
            ),
            Obx(
              () => EasyInfiniteDateTimeLine(
                firstDate: DateTime(2000),
                focusDate: timePicker.selectedDate.value,
                lastDate: DateTime(3000, 12, 31),
                onDateChange: (selectedDate) {
                  timePicker.changeDate(selectedDate);
                },
                selectionMode: const SelectionMode.autoCenter(),
                dayProps: const EasyDayProps(
                  dayStructure: DayStructure.monthDayNumDayStr,
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: Color(0xff5f33e1),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget tasksInfo(Tasks tasks) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xFFF2F2F2)),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Id:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Age:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Salary: ", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tasks.projectName!,
                  style: const TextStyle(fontSize: 17),
                ),
                Text(
                  tasks.description.toString(),
                  style: const TextStyle(fontSize: 17),
                ),
                Text(
                  tasks.startTime.toString(),
                  style: const TextStyle(fontSize: 17),
                ),
                Text(
                  "${tasks.endTime}\$",
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
