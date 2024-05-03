import 'dart:ui';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/get_tasks.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/string_text.dart';

import '../../controller/date_and_task_list.dart';
import '../../controller/show_icons.dart';
import '../all_task_view/all_task_view.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int selectedTabIndex = 0;
  GetTasks tasks = Get.put(GetTasks());
  ShowIcons showList = Get.put(ShowIcons());

  //SortGetTasks sortGetTasks = Get.put(SortGetTasks());
  ShowIcons2 taskManagement = Get.put(ShowIcons2());

  void toWork() {
    taskManagement.iconChange();
    showList.iconChange();
    Logger().d(selectedTabIndex.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toWork();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomePage.id);
              },
              icon: const Icon(IconlyBold.arrow_left),
            ),
            // toolbarHeight: 200,
            title: const Text(
              "Today's Tasks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,fontFamily: "PlexSans"),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    toWork();
                  },
                  icon: const Badge(child: Icon(IconlyBold.notification)))
            ],
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
                Column(
                  children: [
                    EasyDateTimeLine(
                      initialDate: DateTime.now(),
                      onDateChange: (selectedDate) {
                        taskManagement.changeSelectedDate(selectedDate);

                        //`selectedDate` the new date selected.
                      },
                      headerProps: const EasyHeaderProps(
                        monthPickerType: MonthPickerType.switcher,
                        dateFormatter: DateFormatter.fullDateDMY(),
                      ),
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
                    TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelPadding: const EdgeInsets.only(
                        left: 0,
                        right: 7,
                      ),
                      onTap: (index) {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      tabs: [
                        Tab(
                          height: 90,
                          child: category("All"),
                        ),
                        Tab(
                          height: 90,
                          child: category("To do"),
                        ),
                        Tab(height: 90, child: category("In Progress")),
                        Tab(
                          height: 90,
                          child: category("Done"),
                        ),
                        Tab(
                          height: 90,
                          child: category("Plan"),
                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedTabIndex = index;
                          });
                        },
                        children: [
                          Obx(
                            () => ListView.builder(
                                itemCount: showList.showList.length,
                                itemBuilder: (context, index) {
                                  return allTaskView(showList.showList[index]);
                                }),
                          ),
                          Obx(
                            () => ListView.builder(
                                itemCount: taskManagement.showList.length,
                                itemBuilder: (context, index) {
                                  return allTaskView(
                                      taskManagement.showList[index]);
                                }),
                          ),
                          Container(
                            color: Colors.yellow,
                          ),
                          Container(
                            color: Colors.blue,
                          ),
                          Container(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget category(String category) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: list1[selectedTabIndex] == category
              ? const Color(0xff5f33e1)
              : const Color(0xff5f33e1).withOpacity(0.1)),
      child: Text(
        category,
        style: TextStyle(
          fontFamily: "Teachers",
            fontSize: 20,
            color: list1[selectedTabIndex] == category
                ? Colors.white
                : const Color(0xff5f33e1)),
      ),
    );
  }
}
