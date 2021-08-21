import 'package:task/model/event.dart';
import 'package:task/service/http/event.dart';

class EventDetailsController {
  final EventService _eventService;

  EventDetailsController(this._eventService);

  Future<Event> findEventById(int id) {
    return this._eventService.findOne(id);
  }
}
