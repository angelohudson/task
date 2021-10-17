import 'package:task/model/event.dart';

enum TaskStatus { CONFIRMADO, DELETADO, DEFAULT, CONCLUIDA }

class Task {
  final int id;
  Event event;
  TaskStatus taskStatus;
  String memberName;
  String function;

  Task(
    this.id,
    this.event, {
    this.taskStatus,
    this.memberName,
    this.function,
  });

  static Task fromJson(Map<String, dynamic> json) {
    TaskStatus taskStatus = TaskStatus.DEFAULT;
    if (json['status'] != null) {
      taskStatus = TaskStatus.values.firstWhere(
        (t) => t.toString() == "TaskStatus." + json['status'].toString(),
      );
    }
    var event =
        json.containsKey('evento') ? Event.fromJson(json['evento']) : null;
    var task = Task(
      json['id'],
      event,
      taskStatus: taskStatus,
      memberName: json['membro']['nome'],
      function: json['funcaoEscala'],
    );
    return task;
  }
}
