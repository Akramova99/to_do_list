import 'dart:ui';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/get_tasks.dart';
import 'package:to_do_list/controller/sort_get_tasks.dart';
import 'package:to_do_list/model/add_task_model.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int selectedTabIndex = 0;
  GetTasks tasks = Get.put(GetTasks());
  SortGetTasks sortGetTasks = Get.put(SortGetTasks());
  void toWork(){
    sortGetTasks.sumDone();
    sortGetTasks.sumToDo();
    sortGetTasks.sumInProgress();
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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

                      padding: EdgeInsets.zero,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelPadding: const EdgeInsets.only(
                        left: 0,
                        right: 7,
                      ),
                      onTap: (index) {
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
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
                        Tab(height: 90, child: category("In progress")),
                        Tab(
                          height: 90,
                          child: category("Personal"),
                        ),
                        Tab(
                          height: 90,
                          child: category("Work"),
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
                                itemCount: sortGetTasks.toDo.length +
                                    sortGetTasks.done.length +
                                    sortGetTasks.inProgress.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      dailyStudy(sortGetTasks.toDo[index]),
                                      officeProject(sortGetTasks.done[index]),
                                      officeProject(
                                          sortGetTasks.inProgress[index]),
                                      dailyStudy(
                                          sortGetTasks.inProgress[index]),
                                      profileProject(
                                          sortGetTasks.inProgress[index]),
                                      // SizedBox(
                                      //   height: 200,
                                      // )
                                    ],
                                  );
                                }),
                          ),
                          Obx(
                            () => ListView.builder(
                                itemCount: sortGetTasks.toDo.length +
                                    sortGetTasks.done.length +
                                    sortGetTasks.inProgress.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      dailyStudy(sortGetTasks.toDo[index]),
                                      officeProject(sortGetTasks.done[index]),
                                      officeProject(
                                          sortGetTasks.inProgress[index]),
                                      dailyStudy(
                                          sortGetTasks.inProgress[index]),
                                      profileProject(
                                          sortGetTasks.inProgress[index]),
                                      // SizedBox(
                                      //   height: 200,
                                      // )
                                    ],
                                  );
                                }),
                          ),
                          Obx(
                            () => ListView.builder(
                                itemCount: sortGetTasks.toDo.length +
                                    sortGetTasks.done.length +
                                    sortGetTasks.inProgress.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      dailyStudy(sortGetTasks.toDo[index]),
                                      officeProject(sortGetTasks.done[index]),
                                      officeProject(
                                          sortGetTasks.inProgress[index]),
                                      dailyStudy(
                                          sortGetTasks.inProgress[index]),
                                      profileProject(
                                          sortGetTasks.inProgress[index]),
                                      // SizedBox(
                                      //   height: 200,
                                      // )
                                    ],
                                  );
                                }),
                          ),
                          Obx(
                            () => ListView.builder(
                                itemCount: sortGetTasks.toDo.length +
                                    sortGetTasks.done.length +
                                    sortGetTasks.inProgress.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      dailyStudy(sortGetTasks.toDo[index]),
                                      officeProject(sortGetTasks.done[index]),
                                      officeProject(
                                          sortGetTasks.inProgress[index]),
                                      dailyStudy(
                                          sortGetTasks.inProgress[index]),
                                      profileProject(
                                          sortGetTasks.inProgress[index]),
                                      // SizedBox(
                                      //   height: 200,
                                      // )
                                    ],
                                  );
                                }),
                          ),
                          Obx(
                            () => ListView.builder(
                                itemCount: sortGetTasks.toDo.length +
                                    sortGetTasks.done.length +
                                    sortGetTasks.inProgress.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      dailyStudy(sortGetTasks.toDo[index]),
                                      officeProject(sortGetTasks.done[index]),
                                      officeProject(
                                          sortGetTasks.inProgress[index]),
                                      dailyStudy(
                                          sortGetTasks.inProgress[index]),
                                      profileProject(
                                          sortGetTasks.inProgress[index]),
                                      // SizedBox(
                                      //   height: 200,
                                      // )
                                    ],
                                  );
                                }),
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
      margin: const EdgeInsets.only( top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: category == "All"
              ? const Color(0xff5f33e1)
              : const Color(0xff5f33e1).withOpacity(0.1)),
      child: Text(
        category,
        style: TextStyle(
            fontSize: 20,
            color: category == "All" ? Colors.white : Color(0xff5f33e1)),
      ),
    );
  }

  Widget officeProject(Tasks task) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      margin: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
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
                task.projectName!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
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
                      IconlyBold.work,
                      size: 24,
                      color: Colors.pink.withOpacity(0.3),
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            task.description!,
            maxLines: 1,
            style: TextStyle(
              fontSize: 17,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_filled_rounded,
                color: Colors.indigoAccent.shade200,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "10:00 AM",
                style: TextStyle(
                    fontSize: 13, color: Colors.indigoAccent.shade200),
              ),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.only(left: 4, top: 4, right: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff5f33e1).withOpacity(0.1)),
                child: Text(
                  "done",
                  style: TextStyle(
                      fontSize: 12, color: Colors.indigoAccent.shade200),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget dailyStudy(Tasks task) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
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
                task.projectName!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/svg/book.svg",
                      height: 25,
                      width: 25,
                      color: Colors.orange,
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            task.description!,
            maxLines: 1,
            style: const TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis),
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_filled_rounded,
                color: Colors.indigoAccent.shade200,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "9:00 PM",
                style: TextStyle(
                    fontSize: 13, color: Colors.indigoAccent.shade200),
              ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.only(left: 4, top: 4, right: 4),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff5f33e1).withOpacity(0.1)),
                child: Text(
                  "9:00 PM",
                  style: TextStyle(
                      fontSize: 12, color: Colors.indigoAccent.shade200),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget profileProject(Tasks task) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      margin: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
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
                task.projectName!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/svg/user.svg",
                      height: 25,
                      width: 25,
                      color: Colors.purpleAccent.shade100,
                    ),
                  ),
                ),
              )
            ],
          ),
          Text(
            task.description!,
            maxLines: 1,
            style: TextStyle(fontSize: 17),
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_filled_rounded,
                color: Colors.indigoAccent.shade200,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "8:00 AM",
                style: TextStyle(
                    fontSize: 13, color: Colors.indigoAccent.shade200),
              ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.only(left: 4, top: 4, right: 4),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff5f33e1).withOpacity(0.1)),
                child: Text(
                  "In Progress",
                  style: TextStyle(
                      fontSize: 12, color: Colors.indigoAccent.shade200),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
