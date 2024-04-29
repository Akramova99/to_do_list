import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/pages/main_pages/add_project.dart';
import 'package:to_do_list/pages/splash_screen.dart';

Future<void> main()async {
  await Hive.initFlutter();
  await Hive.openBox("addProject");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        HomePage.id:(context)=>const HomePage(),
        AddProject.id:(context)=> AddProject(),
      },
    );
  }
}


