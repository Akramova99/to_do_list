class Tasks {
  String? taskGroup;
  String? projectName;
  String? description;
  String? startDate;
  String? endTime;
  String? stateOfTask;
  String? key;
  bool star;

  Tasks(
      {required this.taskGroup,
      required this.projectName,
      required this.description,
      required this.endTime,
      required this.startDate,
      required this.stateOfTask,
      required this.key,
     required this.star });

  Tasks.fromJson(Map<String, dynamic> mp)
      : taskGroup = mp["taskGroup"],
        projectName = mp["projectName"],
        description = mp["description"],
        endTime = mp["endTime"],
        startDate = mp["startDate"],
        stateOfTask = mp["stateOfTask"],
        key = mp["key"],
        star = mp["star"];

  Map<String, dynamic> toJson() => {
        "taskGroup": taskGroup,
        "projectName": projectName,
        "description": description,
        "startDate": startDate,
        "endTime": endTime,
        "stateOfTask": stateOfTask,
        "key": key,
        "star": star
      };
}
