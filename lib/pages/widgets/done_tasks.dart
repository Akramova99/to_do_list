import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/controller/check_switch.dart';
import 'package:to_do_list/controller/is_star.dart';
import 'package:to_do_list/controller/saveProject.dart';
import 'package:to_do_list/model/add_task_model.dart';

class DoneTasks extends StatefulWidget {
  final Tasks task;

  const DoneTasks({super.key, required this.task});

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    DateTime endDate = DateTime.parse(widget.task.endTime!);
    IsStar checkStar = Get.put(IsStar());
    IsSwitched isSwitched = Get.put(IsSwitched());
    SaveProject saveProject = Get.put(SaveProject());

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xff5f33e1),
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.projectName!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Manrope",
                  color: Color(0xffa2a2a2),
                  fontSize: 22,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Color((0xffa2a2a2)),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/check_calendar.svg",
                    height: 25,
                  ),
                  Text(
                    "${endDate.day}— ${DateFormat('MMMM').format(endDate)} ",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontFamily: "Manrope",
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(child: Container()),
          InkWell(
            splashColor: Colors.brown.shade100,
            borderRadius: BorderRadius.circular(20.0),
            onTap: () {
              setState(() {
                widget.task.star = !widget.task.star;
              });
              checkStar.changeStar(widget.task.star);
              isSwitched.changeSwitch(true);
              saveProject.updateProject(
                  widget.task.projectName!,
                  widget.task.description!,
                  widget.task.key!,
                  widget.task.taskGroup!,
                  false);
              //    task.save(); // Save the updated task in Hive
              Logger().w(widget.task.star);
            },
            child: !widget.task.star
                ? SvgPicture.asset(
                    "assets/svg/star-svgrepo-com.svg",
                  )
                : SvgPicture.asset(
                    "assets/svg/fill_star.svg",
                    color: const Color(0xff5f33e1),
                    height: 25,
                  ),
          ),
        ],
      ),
    );
  }
}
