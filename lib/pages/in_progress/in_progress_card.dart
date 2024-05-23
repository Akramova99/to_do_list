import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/model/add_task_model.dart';


class InProgressCard extends StatelessWidget {
  final Tasks? task;

  const InProgressCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    DateTime endDate =DateTime.parse(task!.endTime!);
    const  List color =[
      Color(0xffe7f3ff),
      Color(0xffffe9e1),
      Color(0xffede4ff),
    ];
    return Container(
      width: 200,
           margin: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: task?.taskGroup! == "Work"? color[0]:( task?.taskGroup! == "Profile"?color[1]:color[2]), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
               task?.taskGroup! == "Work"?"Office Project"  : (task?.taskGroup! == "Daily Study"?"Daily Study":"Personal Project"),
                style: TextStyle(
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey.shade500),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(
                      task?.taskGroup! == "Work"
                          ? IconlyBold.work
                          : (task?.taskGroup! == "Daily Study"
                          ? CupertinoIcons.book_fill
                          : CupertinoIcons.profile_circled),
                      size: 24,
                      color: Colors.pink.withOpacity(0.3),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  maxLines: 2,
                  task!.description!,
                  style: const TextStyle(
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 7.0, top: 10),
                child: Text("Ends on ${endDate.day}th  ${DateFormat('MMMM').format(endDate)}"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
