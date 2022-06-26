import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:task/app/modules/home/model/task.dart';

class Event {
  final int id;
  final String taskname, subtask, describe;
  final DateTime tasktime;
  final Color status;
  List<Task> tasks;
  List<Comment> comments;

  Event(
    this.id,
    this.taskname,
    this.subtask,
    this.tasktime,
    this.status,
    this.describe,
    this.tasks,
    this.comments,
  );

  static Event fromJson(Map<String, dynamic> json) {
    List<Task> tasks = json.containsKey('tasksDto') && json['tasksDto'] != null
        ? json['tasksDto'].map<Task>((task) {
            return Task.fromJson(task);
          }).toList()
        : [];
    List<Comment> comments = json.containsKey('comentarios') &&
            json['comentarios'] != null
        ? json['comentarios'].map<Comment>((c) => Comment.fromJson(c)).toList()
        : [];
    String cor = json['ministerio']['cor'];
    return Event(
      json['id'],
      json['titulo'],
      json['subtitulo'],
      DateFormat("yyyy-MM-dd'T'hh:mm:ss").parse(json['data']),
      Color(cor == null ? null : int.parse(cor)),
      json['descricao'],
      tasks,
      comments,
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, describe: $describe, tasktime: $tasktime, status: $status, tasks: $tasks)';
  }
}

class Comment {
  String memberName;
  String text;
  Comment(this.memberName, this.text);

  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(json['memberName'], json['comentario']);
  }
}
