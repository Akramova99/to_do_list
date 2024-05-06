import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:to_do_list/controller/get2.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/pages/main_pages/only_task.dart';

import '../all_task_view/all_task_view.dart';

class ViewTasks extends StatelessWidget {
  const ViewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    Get2 get2 = Get.put(Get2());
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
                IconButton(
                     onPressed: () {

                      Get.to(const HomePage());
                    },
                    icon: const Icon(IconlyBold.arrow_left)),
                Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: get2.projects.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: (){
                              //   Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //       builder: (context) => const ,
                              //     ),
                              //   );
                              Get.to( OnlyTask(tasks:  get2.projects[index]) );
                            },
                            child: allTaskView(get2.projects[index]));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
