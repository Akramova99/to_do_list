import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/pages/bottom_nav_bar.dart';
import 'package:to_do_list/pages/main_pages/add_project.dart';
import 'package:to_do_list/pages/splash_screen.dart';

import 'model/add_task_model.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // This should be the first line in main()
  AwesomeNotifications().initialize(
    null,
  //  'resource://drawable/res_app_icon', // icon for your notifications
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
    debug: true
  );
  await Hive.initFlutter();
  await Hive.openBox("Tasks");         // Open your Hive box
  await Hive.openBox("profile");         // Open your Hive box

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
        HomePage.id: (context) => const HomePage(),
        AddProject.id: (context) => AddProject(),
      },
    );
  }
}
