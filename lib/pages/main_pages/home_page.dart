import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_do_list/controller/is_badge_visible.dart';
import 'package:to_do_list/controller/percent_of_tasks.dart';
import 'package:to_do_list/controller/pick_and_load_image.dart';
import 'package:to_do_list/pages/main_pages/notification_page.dart';
import 'package:to_do_list/pages/main_pages/view_tasks.dart';
import 'package:to_do_list/service/hive_database.dart';
import 'package:to_do_list/string_text.dart';

import '../in_progress/in_progress_card.dart';
import '../task_group/task_group_card.dart';
import '../task_group/task_group_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HiveService get2 = Get.put(HiveService());
  ImageController imageController = Get.put(ImageController());
  Percent percent = Get.put(Percent());
  IsBadgeVisible visible = Get.put(IsBadgeVisible());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      get2.getTasksForSelectedDate(DateTime.now());
      get2.toDoTasks;
      imageController.loadImage();
      percent.updatePercentView();
      Get.find<Percent>().updatePercentView();
      // Call updatePercentView() here
    });
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
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() => CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipOval(
                              child: Image.file(
                            imageController.image.value!,
                            width: 40,
                            // The width should be double the radius
                            height: 40,
                            // The height should be double the radius
                            fit: BoxFit.cover,
                          )),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Hello!",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16)),
                        Text(
                          get2.getProfile() ?? "Name",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: "PlexSans",
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {
                          Get.to(const Notifications());
                          visible.changeBadge(false);
                        },
                        icon: Obx(() => Badge(
                            isLabelVisible: get2.tasksList.isNotEmpty &&
                                visible.isVisible.value,
                            child: Icon(IconlyBold.notification)))),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Container(
                  height: 170,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: const Color(0xff5f33e1),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                // Ensure percentView is up to date
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Get.find<Percent>()
                                      .updatePercentView(); // Call updatePercentView() here
                                });

                                return Text(
                                  percent.percentView.value > 50.0 &&
                                          percent.percentView.value < 100.0
                                      ? title3
                                      : (percent.percentView.value == 50.0
                                          ? title14
                                          : (percent.percentView.value == 100.0
                                              ? title15
                                              : title16)),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Manrope"),
                                );
                              }),
                              InkWell(
                                splashColor: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                onTap: () {
                                  get2.getTasksForSelectedDate(DateTime.now());
                                  //   get2.dateTask(DateTime.now());
                                  Get.to(() => const ViewTasks());
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 35),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Text(
                                    "View Task",
                                    style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xff5f33e1)),
                                  ),
                                ),
                              )
                            ],
                          )),
                      Expanded(child: Container()),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: Obx(() {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Get.find<Percent>()
                                .updatePercentView(); // Call updatePercentView() here
                          }); // Call updatePercentView() here

                          return CircularPercentIndicator(
                            // fillColor: Colors.red,
                            startAngle: 120,
                            radius: 45.0,
                            lineWidth: 8.0,
                            animation: true,
                            //Percent.percentView / 100  [0;1]
                            percent: percent.percentView / 100,
                            center: Text(
                              "${percent.percentView.toStringAsFixed(1)}%",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.white),
                            ),
                            backgroundColor: const Color(0xff197CEE),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.white,
                          );
                        }),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 32,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(11)),
                          child: const Icon(
                            CupertinoIcons.ellipsis,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Text(
                        "To do tasks",
                        style: TextStyle(
                            fontFamily: "PlexSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.blue.shade50,
                        child: Text(
                          get2.toDoTasks.length.toString(),
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff5f33e1)),
                        ),
                      )
                    ],
                  ),
                ),
                get2.toDoTasks.isEmpty
                    ? SvgPicture.asset(
                        "assets/svg/empty.svg",
                        height: 150,
                        width: 150,
                      )
                    : SizedBox(
                        height: 170,
                        child: Obx(() => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: get2.toDoTasks.length,
                              itemBuilder: (context, index) {
                                return InProgressCard(
                                    task: get2.toDoTasks[index]);
                              },
                            )),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Text(
                        "Task Groups",
                        style: TextStyle(
                            fontFamily: "PlexSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.blue.shade50,
                        child: const Text(
                          "3",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff5f33e1)),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: TaskGroupList.taskProgressList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskGroupCard(
                      taskGroupClass: TaskGroupList.taskProgressList[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
