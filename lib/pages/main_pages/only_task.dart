import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/pages/main_pages/done_task_text.dart';

import '../../model/add_task_model.dart';

class OnlyTask extends StatefulWidget {
  final Tasks? tasks;

  const OnlyTask({super.key, required this.tasks});

  @override
  State<OnlyTask> createState() => _OnlyTaskState();
}

class _OnlyTaskState extends State<OnlyTask> {
  DoneTaskText doneTaskText = Get.put(DoneTaskText());

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    doneTaskText.doneTaskText.value;
  }
  @override
  Widget build(BuildContext context) {
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
                        const Padding(
                          padding: EdgeInsets.only(left: 13.0),
                          child: Text(
                            "Important",
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,

                                fontFamily: "PlexSans"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            widget.tasks!.projectName.toString(),
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Teachers"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 18),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: Colors.pink.shade50,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Icon(
                                widget.tasks?.taskGroup! == "Work"
                                    ? IconlyBold.work
                                    : (widget.tasks?.taskGroup! == "Daily Study"
                                    ? CupertinoIcons.book_fill
                                    : CupertinoIcons.profile_circled),
                                size: 24,
                                color: Colors.pink.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(
                          left: 20, bottom: 20, right: 20, top: 10),
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
                              IconButton(
                                  onPressed: () {
                                    doneTaskText.changeText();
                                  },
                                  icon: Obx(() => Icon(
                                    doneTaskText.doneTaskText.value
                                        ? IconlyLight.tick_square
                                        : Icons.circle_outlined,
                                    size: 30,
                                  ))),
                             Obx(() =>  Text(
                               widget.tasks!.description!,
                               maxLines: 1,
                               style:
                               TextStyle(
                                 decoration: doneTaskText.doneTaskText.value?TextDecoration.lineThrough:TextDecoration.none,

                                 fontSize: 17,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             )),
                              const Padding(
                                padding: EdgeInsets.only(top: 8, right: 8),
                                child: Center(
                                  child: Icon(Icons.star_rounded,
                                      size: 30, color: Color(0xff4147D5)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

