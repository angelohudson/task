import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:task/model/task.dart';

class Event {
  final int id;
  final String taskname, subtask, describe;
  final DateTime tasktime;
  final Color status;
  List<Task> tasks;

  Event(
    this.id,
    this.taskname,
    this.subtask,
    this.tasktime,
    this.status,
    this.describe,
    tasks,
  );

  static Event fromJson(Map<String, dynamic> json) {
    var tasks = json.containsKey('tasksDto') && json['tasksDto'] != null
        ? json['tasksDto'].map((task) => {Task.fromJson(task)}).toList()
        : [];
    return Event(
      json['id'],
      json['titulo'],
      json['subtitulo'],
      DateFormat("yyyy-MM-dd'T'hh:mm:ss").parse(json['data']),
      Color(int.parse(json['ministerio']['cor'])),
      json['descricao'],
      tasks,
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, describe: $describe, tasktime: $tasktime, status: $status, tasks: $tasks)';
  }
}
