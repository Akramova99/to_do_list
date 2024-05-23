import 'dart:ui';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/check_switch.dart';
import 'package:to_do_list/controller/is_badge_visible.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/pages/main_pages/notification_page.dart';
import 'package:to_do_list/pages/main_pages/task_details.dart';
import 'package:to_do_list/service/hive_database.dart';
import 'package:to_do_list/string_text.dart';

import '../widgets/all_task_view.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  HiveService get2 = Get.put(HiveService());
  int selectedTabIndex = 0;
  DateTimePicker dateTimePicker = Get.put(DateTimePicker());
  IsSwitched mySelectedDate = Get.put(IsSwitched());
  IsBadgeVisible visible = Get.put(IsBadgeVisible());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: "PlexSans"),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(const Notifications());
                    visible.changeBadge(false);
                  },
                  icon: Obx(() => Badge(
                      isLabelVisible:
                          get2.tasksList.isNotEmpty && visible.isVisible.value,
                      child: Icon(IconlyBold.notification)))),
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
                        //mySelectedDate.changeSelectedDate(selectedDate);
                        get2.getTasksForSelectedDate(selectedDate);
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
                      tabAlignment: TabAlignment.center,
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelPadding: const EdgeInsets.only(
                        left: 10,
                        right: 20,
                      ),
                      onTap: (index) {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
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
                        Tab(
                          height: 90,
                          child: category("Done"),
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
                          Logger().i(get2.tasksList.length);
                        },
                        children: [
                          if (get2.tasksList.isNotEmpty)
                            Obx(
                              () => ListView.builder(
                                  itemCount: get2.tasksList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        mySelectedDate.changeSwitch(
                                            get2.tasksList[index].stateOfTask ==
                                                    "To do"
                                                ? false
                                                : true);
                                        Get.to(OnTapTask(
                                            tasks: get2.tasksList[index]));
                                      },
                                      child: allTaskView(get2.tasksList[index]),
                                    );
                                  }),
                            ),
                          //  if (get2.tasksList.isEmpty) emptySvg(),

                          Obx(() => ListView.builder(
                                itemCount: get2.toDoTasks.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      mySelectedDate.changeSwitch(false);
                                      Get.to(OnTapTask(
                                          tasks: get2.toDoTasks[index]));
                                    },
                                    child: allTaskView(get2.toDoTasks[index]),
                                  );
                                },
                              )),
                          Obx(() => ListView.builder(
                                itemCount: get2.doneTasks.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      mySelectedDate.changeSwitch(true);
                                      Get.to(OnTapTask(
                                          tasks: get2.doneTasks[index]));
                                    },
                                    child: allTaskView(get2.doneTasks[index]),
                                  );
                                },
                              )),
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

  Widget emptySvg() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SvgPicture.asset(
            "assets/svg/empty.svg",
            height: 200,
            width: 200,
          ),
        ),
        const Text("Data empty"),
      ],
    );
  }
}
// selectedFromCalendar.changeSelectedDate(selectedDate);
// String day = selectedFromCalendar.mySelectedDate.toString().substring(0,10);
// String day = selectedDate.toString().substring(0, 10);
//get2.getSavedTasks(day);
//  get2.dateTask(selectedDate);
// taskManagement.changeSelectedDate(selectedDate);

//`selectedDate` the new date selected.
