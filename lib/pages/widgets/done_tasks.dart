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
    IsSwitched isSwitched =Get.put(IsSwitched());
    SaveProject saveProject = Get.put(SaveProject());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/svg/check-circle-svgrepo-com.svg",
            height: 32,
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
                  fontFamily: "Edu",
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
                        color: Colors.grey, fontSize: 18, fontFamily: 'Edu'),
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
              saveProject.updateProject(widget.task.projectName!, widget.task.description!, widget.task.key!, widget.task.taskGroup!,false);
              //    task.save(); // Save the updated task in Hive
              Logger().w(widget.task.star);
            },
            child: widget.task.star
                ? SvgPicture.asset(
                    "assets/svg/star-svgrepo-com.svg",
                  )
                : SvgPicture.asset(
                    "assets/svg/fill_star.svg",
                    height: 25,
                  ),
          ),
        ],
      ),
    );
  }
}
