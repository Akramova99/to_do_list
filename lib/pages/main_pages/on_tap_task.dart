import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/string_text.dart';

import '../../model/add_task_model.dart';
import '../../service/flutter_toast.dart';

class OnTapTask extends StatefulWidget {
  Tasks tasks;

  OnTapTask({required this.tasks, super.key});

  @override
  State<OnTapTask> createState() => _OnTapTaskState();
}

class _OnTapTaskState extends State<OnTapTask> {
  TextEditingController taskNameCont = TextEditingController();

  TextEditingController descriptionCont = TextEditingController();
  DateTimePicker dateTimePicker = Get.put(DateTimePicker());

  void taskOldView() {
    taskNameCont.text = widget.tasks.projectName!;
    descriptionCont.text = widget.tasks.description!;
    // dateTimePicker.changeDate(DateTime.parse(widget.tasks.startDate!));
    // dateTimePicker.changeEndDate(DateTime.parse(widget.tasks.endTime!));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      taskOldView();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("assets/images/img_1.png"))),
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(const HomePage());
                        },
                        icon: const Icon(IconlyBold.arrow_left)),
                    const Text(
                      "Details of Your Task",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: "PlexSans"),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  margin: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.tasks.taskGroup!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, right: 8),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Colors.pink.shade50,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Icon(
                                  widget.tasks.taskGroup! == "Work"
                                      ? IconlyBold.work
                                      : (widget.tasks.taskGroup! ==
                                              "Daily Study"
                                          ? CupertinoIcons.book_fill
                                          : CupertinoIcons.profile_circled),
                                  size: 24,
                                  color: Colors.pink.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        title12,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: "Inter"),
                      )
                    ],
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  margin: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Project Name"),
                      TextField(
                        controller: taskNameCont,
                        decoration: const InputDecoration(
                            //  hintText: widget.tasks.projectName,
                            //labelText: taskNameCont.text,
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  margin: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description"),
                      TextField(
                        controller: descriptionCont,
                        decoration: const InputDecoration(
                          //  hintText: widget.tasks.projectName,
                          //labelText: taskNameCont.text,
                            labelStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg/Group.svg",
                              height: 21,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Start Date",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Obx(
                            () => Text(
                              "${dateTimePicker.selectedDate.value.day} ${DateFormat('MMMM').format(dateTimePicker.selectedDate.value)} , ${dateTimePicker.selectedDate.value.year} ",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg/Group.svg",
                              height: 21,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "End Date",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Obx(
                            () => Text(
                              "${dateTimePicker.selectedEndDate.value.day} ${DateFormat('MMMM').format(dateTimePicker.selectedEndDate.value)} , ${dateTimePicker.selectedEndDate.value.year}, ",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      Expanded(child: Container()),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
//
