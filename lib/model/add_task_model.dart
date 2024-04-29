class Tasks {
  String? taskGroup;
  String? projectName;
  String? description;
  String? startTime;
  String? endTime;

  Tasks({
    required this.taskGroup,
    required this.projectName,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  Tasks.fromJson(Map<String, dynamic> mp)
      : taskGroup = mp["taskGroup"],
        projectName = mp["projectName"],
        description = mp["description"],
        startTime = mp["startTime"],
        endTime = mp["endTime"];

  Map<String, dynamic> toJson() => {
        "taskGroup": taskGroup,
        "projectName": projectName,
        "description": description,
        "startTime": startTime,
        "endTime": endTime
      };
}
