import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/service/hive_database.dart';
import 'package:to_do_list/string_text.dart';

import '../widgets/all_task_view.dart';

class ViewTasks extends StatelessWidget {
  const ViewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    HiveService get2 = Get.put(HiveService());
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(const HomePage());
                        },
                        icon: const Icon(IconlyBold.arrow_left)),
                    Expanded(child: Container()),
                    const Text(
                      "View Tasks  ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: "PlexSans"),
                    ),
                    Expanded(child: Container()),

                  ],
                ),
                get2.tasksList.isNotEmpty
                    ? Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: get2.tasksList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // mySelectedDate.changeSwitch(get2.tasksList[index].stateOfTask=="To do"? false:true);
                                  //
                                  // Get.to(
                                  //     OnTapTask(
                                  //         tasks: get2.tasksList[index]));
                                },
                                child: allTaskView(get2.tasksList[index]),
                              );
                            }),
                      )
                    : emptySvg(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget emptySvg() {
    return Column(
      children: [
         Text(title13,style:
         const TextStyle(fontFamily: "Teachers",fontSize: 20),),
        SizedBox(height: 150,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SvgPicture.asset(
            "assets/svg/empty.svg",
            height: 200,
            width: 200,
          ),
        ),

      ],
    );
  }
}
