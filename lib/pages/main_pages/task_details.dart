import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/controller/check_switch.dart';
import 'package:to_do_list/controller/is_star.dart';
import 'package:to_do_list/controller/saveProject.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import 'package:to_do_list/service/hive_database.dart';

import '../../controller/percent_of_tasks.dart';
import '../../model/add_task_model.dart';

class OnTapTask extends StatefulWidget {
  final Tasks tasks;

  const OnTapTask({required this.tasks, super.key});

  @override
  State<OnTapTask> createState() => _OnTapTaskState();
}

class _OnTapTaskState extends State<OnTapTask> {
  TextEditingController descriptionCont = TextEditingController();
  TextEditingController taskNameCont = TextEditingController();
  DateTimePicker dateTimePicker = Get.put(DateTimePicker());
  SaveProject saveProject = Get.put(SaveProject());
  IsSwitched checkSwitch = Get.put(IsSwitched());
  IsStar isStar =Get.put(IsStar());
  HiveService get2 = Get.put(HiveService());

  void taskOldView() {
    taskNameCont.text = widget.tasks.projectName!;
    descriptionCont.text = widget.tasks.description!;
  }

  @override
  void initState() {
    super.initState();
    taskOldView();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate = DateTime.parse(widget.tasks.startDate!);
    DateTime endDate = DateTime.parse(widget.tasks.endTime!);

    return Scaffold(
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
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text(
                    "Task Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(IconlyBold.arrow_left),
                  ),
                  actions: [
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: Stack(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(IconlyBold.notification),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey.withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Task Name",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: TextField(
                                controller: taskNameCont,
                                decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey.withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Task's Group",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              widget.tasks.taskGroup!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                          ],
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  const Text(
                                    "Do you want to edit?",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey.withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Date",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "${startDate.day} ${DateFormat('MMMM').format(startDate)} , ${startDate.year}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "End Date",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "${endDate.day} ${DateFormat('MMMM').format(endDate)} , ${endDate.year}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey.withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: TextField(
                                controller: descriptionCont,
                                decoration: const InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  const Text(
                                    "Do you want to edit?",
                                    maxLines: 5,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey.withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Done",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Obx(() => Switch(
                            activeColor: const Color(0xff5f33e1),
                            value: checkSwitch.isSwitched.value,
                            onChanged: (value) {
                              checkSwitch.changeSwitch(value);
                              //  changeSwitch();
                            }))
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 15, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey.withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "If you want to change the state of task",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            Row(
                              children: [
                                const Text("Please tab on this button"),
                                const SizedBox(
                                  width: 20,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () {
                                      isStar.changeStar(false);
                                      saveProject.updateProject(
                                          taskNameCont.text.trim(),
                                          descriptionCont.text.trim(),
                                          widget.tasks.key!,
                                          widget.tasks.taskGroup!,true);

                                      get2.getTasksForSelectedDate(
                                          DateTime.now());
                                      Get.find<Percent>()
                                          .updatePercentView(); // Call updatePercentView() here
                                    },
                                    child: Container(
                                      height: 22,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff359fff)
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: const Center(
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              color: Color(0xff359fff),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//
