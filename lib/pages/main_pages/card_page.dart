import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:to_do_list/model/add_task_model.dart';
import 'package:to_do_list/service/save_add_project.dart';

class CardScreen extends StatelessWidget {
  CardScreen({super.key});

  void getInfo() {
    SaveAddProject.getProject(objKey: "addProject");
  }

  final Tasks tasks = SaveAddProject.getProject(objKey: "addProject");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(tasks.taskGroup!),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.reorder,
                color: Colors.black,
              ))
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

          ],
        ),
      ),
    );
  }
}
