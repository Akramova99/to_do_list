 import 'package:awesome_notifications/awesome_notifications.dart';

import '../model/add_task_model.dart';

class NotificationChannel {
 static  scheduleTaskNotification(Tasks task) {
     DateTime startDate = DateTime.parse(task.startDate!);
     DateTime notificationTime = DateTime(
       startDate.year,
       startDate.month,
       startDate.day,
       19, // 9:00 AM
       57,
     );

     return AwesomeNotifications().createNotification(
       content: NotificationContent(
         id: createUniqueId(),
         channelKey: 'basic_channel',
         title: 'Task Reminder: ${task.projectName}',
         body: 'Your task "${task.description}" is starting today.',
         notificationLayout: NotificationLayout.Default,
       //playState: NotificationPlayState.
       //  category: NotificationCategory.

       ),
       actionButtons: [
         NotificationActionButton(
           key: 'LATER',
           label: 'Execute',
           actionType: ActionType.Default,
           autoDismissible: true, // This will close the notification
         ),
         NotificationActionButton(
           key: 'DONE',
           label: 'Edit',
           actionType: ActionType.Default,
           autoDismissible: true, // This will close the notification
         ),
       ],
       schedule: NotificationCalendar(
         year: notificationTime.year,
         month: notificationTime.month,
         day: notificationTime.day,
         hour: notificationTime.hour,
         minute: notificationTime.minute,
         second: 0,
         millisecond: 0,
         repeats: true,
       ),
     );
   }
  static int createUniqueId() {
     return DateTime.now().millisecondsSinceEpoch.remainder(20);
   }
//100000
 }