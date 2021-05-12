import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

enum TaskStatus { CONFIRMADO, DELETADO, DEFAULT }

class Task {
  final int id;
  final String taskname, subtask, describe;
  final DateTime tasktime;
  TaskStatus taskStatus;
  final Color status;

  Task(
    this.id,
    this.taskname,
    this.subtask,
    this.tasktime,
    this.status,
    this.describe, {
    this.taskStatus,
  });

  static Task fromJson(Map<String, dynamic> json) {
    TaskStatus taskStatus = TaskStatus.DEFAULT;
    if (json['status'] != null) {
      taskStatus = TaskStatus.values.firstWhere(
        (t) => t.toString() == "TaskStatus." + json['status'].toString(),
      );
    }
    var task = Task(
      json['id'],
      json['titulo'],
      json['subtitulo'],
      DateFormat("yyyy-MM-dd'T'hh:mm:ss").parse(json['data']),
      Color(int.parse(json['ministerio']['cor'])),
      json['descricao'],
      taskStatus: taskStatus,
    );
    return task;
  }

  dynamic toJson() {
    return {
      'id': this.id,
      'titulo': this.taskname,
      'subtitulo': this.subtask,
      'data': DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(tasktime),
      'descricao': this.describe,
    };
  }
}
