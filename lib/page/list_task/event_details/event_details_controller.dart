import 'package:task/model/event.dart';
import 'package:task/model/task.dart';
import 'package:task/service/http/event.dart';

class EventDetailsController {
  final EventService _eventService;

  EventDetailsController(this._eventService);

  Future<Event> findEventById(int id) async {
    Event event = await this._eventService.findOne(id);
    event.tasks = event.tasks
        .where((t) => (t != null && t.taskStatus != TaskStatus.DELETADO))
        .toList();
    return event;
  }

  Future<void> addComment(int eventId, String newComment) {
    return this._eventService.addComment(eventId, newComment);
  }
}
