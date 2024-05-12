import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/controller/saveProject.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/service/flutter_toast.dart';
import 'package:to_do_list/service/hive_database.dart';

import '../../controller/menu_controller.dart';
import '../../controller/time_picker_controller.dart';

class AddProject extends StatefulWidget {
  static const String id = "add_project";

  AddProject({super.key});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final TextEditingController nameProjectCont = TextEditingController();

  final TextEditingController descriptionCont = TextEditingController();

  final ExpansionTileMenu expansionTile = Get.put(ExpansionTileMenu());

  final GlobalKey popupMenuButtonKey = GlobalKey();

  DateTimePicker dateTimePicker = Get.put(DateTimePicker());

  SaveProject saveProject = Get.put(SaveProject());

  HiveService hiveService = Get.put(HiveService());

  final String item1 = "Profile";

  final String item2 = "Daily Study";

  final String item3 = "Work";

  void taskOldView() {
    dateTimePicker.selectedEndDate.value = DateTime.now();
    dateTimePicker.selectedDate.value = DateTime.now();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskOldView();
    });
  }

  // void saveData()async{
  //   String key =  dateTimePicker.selectedDate.value.toString().substring(0,10);
  //   List<Tasks> lst = [];
  //   if (await hiveService.getTasks(key) == null) {
  //     saveProject.addProject(nameProjectCont.text.trim(), descriptionCont.text.trim());
  //      hiveService.storeTasks(saveProject.listTask, key);
  //     Future.delayed(Duration.zero);
  //   } else {
  //     for (Tasks item in await hiveService.getTasks(key)) {
  //       lst.add(item);
  //     }
  //     saveProject.addProject(nameProjectCont.text.trim(), descriptionCont.text.trim());
  //     lst.add(saveProject.listTask.first);
  //     showToast("Stored Successfully");
  //     hiveService.storeTasks(lst, key);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ExpansionTileMenu menu = Get.put(ExpansionTileMenu());
    SaveProject saveProject = Get.put(SaveProject());

    void startDate({required DateTime date}) async {
      if (GetPlatform.isAndroid) {
        final DateTime? dateTime = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
          initialDate: DateTime.now(),
        );
        if (dateTime != null) {
          dateTimePicker.changeDate(dateTime);
        }
      } else if (GetPlatform.isIOS) {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,
                    initialDateTime: date,
                    onDateTimeChanged: (DateTime dateTime) {
                      dateTimePicker.changeDate(dateTime);
                    },
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.date,
                  ),
                ));
      }
    }

    void endDate({required DateTime date}) async {
      if (GetPlatform.isAndroid) {
        final DateTime? dateTime = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(3000),
          initialDate: dateTimePicker.selectedDate.value,
        );
        if (dateTime != null &&
            dateTime.isAfter(dateTimePicker.selectedDate.value
                .subtract(const Duration(days: 1)))) {
          dateTimePicker.changeEndDate(dateTime);
        } else {
          showToast("Not a valid end date");
        }
      } else if (GetPlatform.isIOS) {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,
                    initialDateTime: date,
                    onDateTimeChanged: (DateTime dateTime) {
                      dateTimePicker.changeEndDate(dateTime);
                    },
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.date,
                  ),
                ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomePage.id);
          },
          icon: const Icon(IconlyBold.arrow_left),
        ),
        title: const Text(
          "Add Project",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "PlexSans"),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
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
            ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    dynamic state = popupMenuButtonKey.currentState;
                    state.showButtonMenu();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Obx(() => Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: menu.colorIcon.value.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Icon(
                                menu.title.value == "Work"
                                    ? IconlyBold.work
                                    : (menu.title.value == "Daily Study"
                                        ? CupertinoIcons.book_fill
                                        : CupertinoIcons.profile_circled),
                                size: 20,
                                color: menu.colorIcon.value,
                              ),
                            ),
                          )),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Task Group",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          Obx(() => Text(
                                menu.title.value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        key: popupMenuButtonKey,
                        child: const Icon(IconlyBold.arrow_down_2),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: item1,
                            child: Container(
                              width: 300,
                              margin: const EdgeInsets.only(bottom: 7),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Obx(
                                        () => Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: menu.colorIcon.value
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Icon(
                                              item1 == "Work"
                                                  ? IconlyBold.work
                                                  : (item3 == "Daily Study"
                                                      ? CupertinoIcons.book_fill
                                                      : CupertinoIcons
                                                          .profile_circled),
                                              size: 20,
                                              color: menu.colorIcon.value,
                                            ),
                                          ),
                                        ),
                                      )),
                                  Text(item1),
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                              value: item2,
                              child: Obx(() => Container(
                                  width: 300,
                                  margin: const EdgeInsets.only(bottom: 7),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: menu.colorIcon.value
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Icon(
                                              item1 == "Work"
                                                  ? IconlyBold.work
                                                  : (item2 == "Daily Study"
                                                      ? CupertinoIcons.book_fill
                                                      : CupertinoIcons
                                                          .profile_circled),
                                              size: 20,
                                              color: menu.colorIcon.value,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(item2),
                                    ],
                                  )))),
                          PopupMenuItem(
                            value: item3,
                            child: Obx(() => Container(
                                width: 300,
                                // margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: menu.colorIcon.value
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Icon(
                                            item3 == "Work"
                                                ? IconlyBold.work
                                                : (item2 == "Daily Study"
                                                    ? CupertinoIcons.book_fill
                                                    : CupertinoIcons
                                                        .profile_circled),
                                            size: 20,
                                            color: menu.colorIcon.value,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(item3),
                                  ],
                                ))),
                          ),
                        ],
                        onSelected: (String newValue) {
                          menu.changeText(newValue);
                        },
                      ),
                    ),
                  ),
                ),

                ///variable as icon, color, String task name
                ///variable as icon, color, String task name
                ///variable as icon, color, String task name
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  padding: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: nameProjectCont,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Project Name",
                        labelStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        hintText: "Enter",
                        hintStyle: TextStyle(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.w300)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  padding: const EdgeInsets.only(left: 12, bottom: 12, top: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      TextField(
                        controller: descriptionCont,
                        cursorColor: Colors.black,
                        maxLength: 500,
                        maxLines: 3,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter",
                            hintStyle: TextStyle(
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.w300)),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    startDate(date: dateTimePicker.selectedDate.value);
                  },
                  child: Container(
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
                        const Icon(IconlyBold.arrow_down_2)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    endDate(date: dateTimePicker.selectedEndDate.value);
                  },
                  child: Container(
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
                                "${dateTimePicker.selectedEndDate.value.day} ${DateFormat('MMMM').format(dateTimePicker.selectedEndDate.value)} , ${dateTimePicker.selectedEndDate.value.year} ",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        const Icon(IconlyBold.arrow_down_2)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          saveProject.addProject(
              nameProjectCont.text.trim(), descriptionCont.text.trim());
          hiveService.getObj();
          //   get2.getSavedTasks(selectedFromCalendar.mySelectedDate.toString().substring(0,10));
          nameProjectCont.clear();
          descriptionCont.clear();
          dateTimePicker.makeInitial();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: 50.0,
          decoration: BoxDecoration(
            color: const Color(0xff4147D5),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Project",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
