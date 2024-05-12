import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controller/profile_controller.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import 'package:to_do_list/service/hive_database.dart';

import '../../controller/pick_and_load_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  final ProfileController profileController = Get.put(ProfileController());
  final HiveService hiveService = Get.put(HiveService());

  void nextLabel() {
    setState(() {
      if (hiveService.getProfile() != "Name") {
        nameController.text = hiveService.getProfile();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextLabel();
  }

  @override
  Widget build(BuildContext context) {
    DateTimePicker timePicker = Get.put(DateTimePicker());
    final ImageController imageController = Get.put(ImageController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "data",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 30,
                    width: double.infinity,
                  ),
                  GestureDetector(
                      onTap: () {
                        imageController.pickImage();
                        imageController.loadImage();
                      },
                      child: Obx(
                        () => CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: imageController.image != null
                                ? Image.file(
                                    imageController.image.value!,
                                    width:
                                        100, // The width should be double the radius
                                    height:
                                        100, // The height should be double the radius
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    "assets/svg/profile.svg",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      )),
                  const Text(
                    "Upload your image / editing",
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                        child: TextField(
                          controller: nameController,
                          //      focusNode: _focusNode,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Name",
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: double.infinity),
                        TextButton(
                            onPressed: () {
                              profileController
                                  .saveName(nameController.text.trim());
                              hiveService.storeProfile(
                                  name: nameController.text.trim());
                            },
                            child: const Text("Save",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blue))),
                      ],
                    ),
                  ),
                  const Divider(),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: double.infinity,),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                   ListTile(
                    title: const Text(
                      "Notifications for tasks due today",
                      style: TextStyle(fontSize: 18,height: 1),
                    ),
                    trailing:Switch(value: true, onChanged: (bool value) {  },),
                  ),
                   const ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notifications about when tasks are due today",
                          style: TextStyle(fontSize: 18,height: 1),
                        ),
                        Text(
                          "8.00",
                          style: TextStyle(fontSize: 16,color: Colors.blue),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
