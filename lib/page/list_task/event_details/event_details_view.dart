import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/page/list_task/event_details/event_details_controller.dart';
import 'package:task/service/http/event.dart';

class EventDetailsView extends StatefulWidget {
  final int _id;

  EventDetailsView(this._id);

  @override
  State<StatefulWidget> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  EventDetailsController _controller =
      new EventDetailsController(new EventService());

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.findEventById(this.widget._id),
      builder: (_, snapshot) {
        return Text(snapshot.data.toString());
      },
    );
  }
}
