import 'package:hive/hive.dart';

part 'add_task_model.g.dart';

@HiveType(typeId: 0)
class Tasks {
  @HiveField(0)
  String? taskGroup;
  @HiveField(1)
  String? projectName;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? startDate;
  @HiveField(4)
  String? endTime;

  Tasks(
      {required this.taskGroup,
      required this.projectName,
      required this.description,
      required this.endTime,
      required this.startDate});

  Tasks.fromJson(Map<String, dynamic> mp)
      : taskGroup = mp["taskGroup"],
        projectName = mp["projectName"],
        description = mp["description"],
        endTime = mp["endTime"],
        startDate = mp["startDate"];

  Map<String, dynamic> toJson() => {
        "taskGroup": taskGroup,
        "projectName": projectName,
        "description": description,
        "endTime": endTime
      };
}
