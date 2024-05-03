class Tasks {
  String? taskGroup;
  String? projectName;
  String? description;
  String? startDate;
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
