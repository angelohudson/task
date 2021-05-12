import 'dart:convert';

import 'package:task/model/task.dart';
import 'package:task/service/web_client.dart';
import 'package:http/http.dart';

class TaskService extends WebClient {
  final String _resource = "task";

  @override
  Future<List<Task>> findAll() async {
    try {
      Response response = await super.getEntity(path: "$_resource");
      List<dynamic> body = jsonDecode(response.body);

      List<Task> tasks = body.map((taskJson) {
        return Task.fromJson(taskJson);
      }).toList();

      return tasks;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return null;
    }
  }

  Future<bool> cancelTask(Task task, just) async {
    try {
      Response response = await super.updateEntity(
        jsonEncode({"justificativa": just}),
        path: "$_resource\/cancela-task/" + task.id.toString(),
      );
      return response.statusCode == 200;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return false;
    }
  }

  Future<bool> confirmTask(Task task) async {
    try {
      Response response = await super.updateEntity(
        jsonEncode({"justificativa": "Teste"}),
        path: "$_resource\/confirma-task/" + task.id.toString(),
      );
      return response.statusCode == 200;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return false;
    }
  }

  @override
  Future update(json) {
    throw UnimplementedError();
  }

  @override
  Future save(user) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) async {
    throw UnimplementedError();
  }
}
