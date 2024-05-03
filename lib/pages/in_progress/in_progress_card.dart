import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:to_do_list/pages/in_progress/in_progress_class.dart';
class InProgressCard extends StatelessWidget {
  final InProgressClass ? card;

   const InProgressCard({super.key,required this.card});

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: 200,
      margin: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: card!.colorCard,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card!.typeTask!,
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
                      color: card?.iconColor?.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Icon(
                      card!.iconOfTask,
                      size: 24,
                      color: card?.iconColor?.withOpacity(0.9),
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
                  card!.taskName.toString(),
                  style: const TextStyle(
fontFamily: "Manrope",
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 10),
                child: LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  width: 160.0,
                  animation: true,
                  lineHeight: 8.0,
                  percent: card!.percentTask!/100,
                  barRadius: const Radius.circular(5),
                  backgroundColor: Colors.white,
                  progressColor: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
