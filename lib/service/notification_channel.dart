import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controller/time_picker_controller.dart';
import '../model/add_task_model.dart';

class NotificationChannel {
 static DateTimePicker timePicker = Get.put(DateTimePicker());
  static scheduleTaskNotification(Tasks task, bool isNotificationEnabled) {
    if (isNotificationEnabled) {
      DateTime startDate = DateTime.parse(task.startDate!);
      DateTime notificationTime = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        timePicker.timeOfDay.value.hour, // default
        timePicker.timeOfDay.value.minute,

      );

      return AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'basic_channel',
          title: 'Task Reminder: ${task.projectName}',
          body: 'Your task "${task.description}" is starting today.',
          notificationLayout: NotificationLayout.Default,
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
    } else {
      // Cancel all notifications if the switch is off
      AwesomeNotifications().cancelAll();
    }
  }

  static int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(20);
  }
}