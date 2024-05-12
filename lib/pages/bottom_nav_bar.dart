import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/service/hive_database.dart';

import '../controller/pick_and_load_image.dart';
import 'main_pages/add_project.dart';
import 'main_pages/card_page.dart';
import 'main_pages/home_page.dart';
import 'main_pages/profile_page.dart';
import 'main_pages/task_page.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HiveService hiveService = Get.put(HiveService());
  final ImageController imageController = Get.put(ImageController());

  int selectedPage = 0;

  final List<dynamic> _pageOptions = [
    HomeScreen(),
    const TaskScreen(),
    const CardScreen(),
    ProfileScreen(),
  ];
  final List<IconData> iconList = [
    IconlyBold.home,
    IconlyBold.calendar,
    IconlyBold.paper,
    IconlyBold.user_2,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      extendBody: true,
      body: _pageOptions[selectedPage],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Positions FAB in center

      floatingActionButton: Hero(
        tag: 'addButton', // Unique tag for the Hero animation
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: const Color(0xff5f33e1),
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AddProject.id);
          },
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        hideAnimationCurve: Curves.bounceInOut,
        backgroundColor: const Color(0xffeee9ff).withOpacity(0.6),
        activeColor: const Color(0xff5f33e1),
        inactiveColor: const Color(0xffb5a0f3),
        icons: iconList,
        activeIndex: selectedPage,
        notchMargin: 10,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
          if (index == 1) {
            hiveService.getTasksForSelectedDate(DateTime.now());
            Logger().w("get2.obj done");
          }
          if (index == 3) {
            imageController.loadImage();
            Logger().w("load image done");
          }
        }, //other params
      ),
    );
  }
}
