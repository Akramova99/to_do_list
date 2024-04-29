import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
List <Padding> iconsList=[
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
  ),

];
List<Widget> children = [
  Row(
    children: [
      Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 10),
        child: iconsList[1],
      ),
      const Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            "Task Group",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "Daily Study",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  ),
  Row(
    children: [
      Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 10),
        child: iconsList[2],
      ),
      const Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            "Task Group",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "Profile",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  ),
];