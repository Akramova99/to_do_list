import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_do_list/controller/percent_of_tasks.dart';
import 'package:to_do_list/controller/pick_and_load_image.dart';
import 'package:to_do_list/pages/main_pages/view_tasks.dart';
import 'package:to_do_list/service/hive_database.dart';
import 'package:to_do_list/string_text.dart';

import '../in_progress/in_progress_card.dart';
import '../in_progress/in_progress_class.dart';
import '../task_group/task_group_card.dart';
import '../task_group/task_group_class.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HiveService get2 = Get.put(HiveService());

  @override
  Widget build(BuildContext context) {
    ImageController imageController = Get.put(ImageController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      get2.getTasksForSelectedDate(DateTime.now());
      Percent
          .updatePercentView(); // Ensure percentView is updated when the home page is opened
      imageController.loadImage();
    });

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
                            child: imageController.image != null
                                ? Image.file(
                                    imageController.image.value!,
                                    width:
                                        40, // The width should be double the radius
                                    height:
                                        40, // The height should be double the radius
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    "assets/svg/profile.svg",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                          ),
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
                          Logger().i(Percent.check);
                        },
                        icon: Badge(child: Icon(IconlyBold.notification))),
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
                              if (Percent.percentView.value > 50 &&
                                  Percent.percentView.value < 100)
                                Text(
                                  title3,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Manrope"),
                                ),
                              if (Percent.percentView.value < 50)
                                Text(
                                  title16,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Manrope"),
                                ),
                              if (Percent.percentView.value == 50)
                                Text(
                                  title14,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Manrope"),
                                ),
                              if (Percent.percentView.value == 100)
                                Text(
                                  title15,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Manrope"),
                                ),
                              // Expanded(child: Container()),
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
                        child: CircularPercentIndicator(
                          // fillColor: Colors.red,
                          startAngle: 120,
                          radius: 45.0,
                          lineWidth: 8.0,
                          animation: true,
                          percent: Percent.percentView / 100,
                          center: Text(
                            "${Percent.percentView.toStringAsFixed(1)}%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.white),
                          ),
                          backgroundColor: Color(0xff197CEE),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.white,
                        ),
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
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Text(
                        "In Progress",
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
                          "6",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff5f33e1)),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    height: 165,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: InProgressList.inProgressList.length,
                        itemBuilder: (context, index) {
                          return InProgressCard(
                              card: InProgressList.inProgressList[index]);
                        }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
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
                          "4",
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
