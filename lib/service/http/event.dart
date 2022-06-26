import 'dart:convert';

import 'package:task/model/event.dart';
import 'package:task/service/web_client.dart';
import 'package:http/http.dart';

class EventService extends WebClient {
  final String _resource = "/task-api/evento";

  Future<bool> addComment(int eventId, String newComment) async {
    try {
      Response response = await super.updateEntity(
        jsonEncode({"comentario": newComment}),
        path: "$_resource/$eventId/comentario",
      );
      return response.statusCode == 200;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return false;
    }
  }

  @override
  Future<Event> findOne(int id) async {
    try {
      Response response = await super.getEntity(path: "$_resource/$id");
      Map<String, dynamic> body = jsonDecode(response.body);
      Event event = Event.fromJson(body);
      return event;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return null;
    }
  }

  @override
  Future<List<Event>> findAll() async {
    throw UnimplementedError();
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
