import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_do_list/controller/get2.dart';
import 'package:to_do_list/pages/main_pages/view_tasks.dart';
import 'package:to_do_list/string_text.dart';

import '../in_progress/in_progress_card.dart';
import '../in_progress/in_progress_class.dart';
import '../task_group/task_group_card.dart';
import '../task_group/task_group_class.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    Get2 get2 = Get.put(Get2());
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const SizedBox(width: 10,),

                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(("assets/svg/profile.svg")),
                        ),
                        const SizedBox(width: 20,),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hello!",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                            Text(
                              "Username",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,fontFamily: "PlexSans",),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        IconButton(
                            onPressed: () {
                              Logger().i(MediaQuery.of(context).size.width);
                            },
                            icon: Badge(child: Icon(IconlyBold.notification))),
                        const SizedBox(width: 10,),


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
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title3,
                                    style: const TextStyle(color: Colors.white,fontFamily: "Manrope"),
                                  ),
                                  // Expanded(child: Container()),
                                  GestureDetector(
                                    onTap: (){
                                      get2.dateTask(DateTime.now());
                                      Get.to(const ViewTasks());
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
                              percent: 0.7,
                              center: const Text(
                                "70.0%",
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
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue.shade50,
                            child: const Text(
                              "6",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff5f33e1)),
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
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue.shade50,
                            child: Text(
                              "4",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff5f33e1)),
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

  // Widget taskGroups() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(top: 20, left: 20, right: 20),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(10),
  //                 child: Container(
  //                   width: 40,
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                       color: Colors.pink.shade50,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: Center(
  //                     child: Icon(
  //                       IconlyBold.work,
  //                       size: 24,
  //                       color: Colors.pink.withOpacity(0.3),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Office Project",
  //                     style:
  //                         TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  //                   ),
  //                   Text(
  //                     "23 tasks",
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  //                   ),
  //                 ],
  //               ),
  //               Expanded(child: Container()),
  //               CircleAvatar(
  //                 radius: 35,
  //                 backgroundColor: Colors.transparent,
  //                 child: CircularPercentIndicator(
  //                   // fillColor: Colors.red,
  //                   startAngle: 120,
  //                   radius: 25.0,
  //                   lineWidth: 5.0,
  //                   animation: true,
  //                   percent: 0.7,
  //                   center: Text(
  //                     "70.0%",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 10.0,
  //                         color: Colors.black),
  //                   ),
  //                   backgroundColor: Colors.pink.shade50,
  //                   circularStrokeCap: CircularStrokeCap.round,
  //                   progressColor: Colors.pink.shade200,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 20, left: 20, right: 20),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(10),
  //                 child: Container(
  //                   width: 40,
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                       color: Colors.purple.shade50,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: Center(
  //                     child: SvgPicture.asset(
  //                       "assets/svg/user.svg",
  //                       height: 30,
  //                       width: 30,
  //                       color: Colors.purpleAccent.shade100,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Personal Project",
  //                     style:
  //                         TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  //                   ),
  //                   Text(
  //                     "30 tasks",
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  //                   ),
  //                 ],
  //               ),
  //               Expanded(child: Container()),
  //               CircleAvatar(
  //                 radius: 35,
  //                 backgroundColor: Colors.transparent,
  //                 child: CircularPercentIndicator(
  //                   // fillColor: Colors.red,
  //                   startAngle: 40,
  //                   radius: 25.0,
  //                   lineWidth: 5.0,
  //                   animation: true,
  //                   percent: 0.7,
  //                   center: Text(
  //                     "70.0%",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 10.0,
  //                         color: Colors.black),
  //                   ),
  //                   backgroundColor: Colors.pink.shade100,
  //                   circularStrokeCap: CircularStrokeCap.round,
  //                   progressColor: Colors.purple.shade200,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 20, left: 20, right: 20),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(10),
  //                 child: Container(
  //                   width: 40,
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                       color: Colors.orange.shade50,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: Center(
  //                     child: SvgPicture.asset(
  //                       "assets/svg/book.svg",
  //                       height: 30,
  //                       width: 30,
  //                       color: Colors.orange,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Daily Study",
  //                     style:
  //                         TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  //                   ),
  //                   Text(
  //                     "2 tasks",
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  //                   ),
  //                 ],
  //               ),
  //               Expanded(child: Container()),
  //               CircleAvatar(
  //                 radius: 35,
  //                 backgroundColor: Colors.transparent,
  //                 child: CircularPercentIndicator(
  //                   // fillColor: Colors.red,
  //                   startAngle: 70,
  //                   radius: 25.0,
  //                   lineWidth: 5.0,
  //                   animation: true,
  //                   percent: 0.7,
  //                   center: Text(
  //                     "70.0%",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 10.0,
  //                         color: Colors.black),
  //                   ),
  //                   backgroundColor: Colors.orange.shade100,
  //                   circularStrokeCap: CircularStrokeCap.round,
  //                   progressColor: Colors.orange.shade300,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(10),
  //                 child: Container(
  //                   width: 40,
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                       color: Colors.indigo.shade50,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: Center(
  //                     child: SvgPicture.asset(
  //                       "assets/svg/health.svg",
  //                       height: 30,
  //                       width: 30,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Heath",
  //                     style:
  //                         TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
  //                   ),
  //                   Text(
  //                     "18 tasks",
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  //                   ),
  //                 ],
  //               ),
  //               Expanded(child: Container()),
  //               CircleAvatar(
  //                 radius: 35,
  //                 backgroundColor: Colors.transparent,
  //                 child: CircularPercentIndicator(
  //                   // fillColor: Colors.red,
  //
  //                   startAngle: 20,
  //                   radius: 25.0,
  //                   lineWidth: 5.0,
  //                   animation: true,
  //                   percent: 0.7,
  //                   center: Text(
  //                     "70.0%",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 10.0,
  //                         color: Colors.black),
  //                   ),
  //                   backgroundColor: Color(0xffE09EEE),
  //                   circularStrokeCap: CircularStrokeCap.round,
  //                   progressColor: Color(0xff4147D5),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
