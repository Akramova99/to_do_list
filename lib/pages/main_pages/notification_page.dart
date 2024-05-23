import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/model/add_task_model.dart';
import 'package:to_do_list/service/hive_database.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  HiveService get2 = Get.put(HiveService());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(IconlyBold.arrow_left),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "PlexSans"),
        ),
        centerTitle: true,
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
              () => ListView.builder(
                  itemCount: get2.allTasks.length,
                  itemBuilder: (context, index) {
                    return note(get2.allTasks[index]);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget note(Tasks task) {
    DateTime endDate = DateTime.parse(task.endTime!);

    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1.0,
            // Adjust blur radius for desired softness
            spreadRadius: 1.0,
            // Adjust spread radius for shadow extent
            offset: Offset(2.0, 2.0), // Adjust offset for shadow direction
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: 4,
            height: 50,
            decoration: BoxDecoration(
                color: Color(0xff18a53c),
                borderRadius: BorderRadius.circular(3)),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Reminder: ${task.projectName}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/Group.svg",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('EEEE').format(DateTime.parse(task.startDate!)).substring(0, 3),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),

                  Text(
                    " —${endDate.day} ${DateFormat('MMMM').format(endDate)} , ${endDate.year}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
