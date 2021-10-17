import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/model/event.dart';
import 'package:task/page/list_task/event_details/event_details_controller.dart';
import 'package:task/page/list_task/event_details/screen/event_comments.dart';
import 'package:task/page/list_task/event_details/screen/table_schedule.dart';
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

  Future<Event> future;

  @override
  void initState() {
    super.initState();
    this.future = _controller.findEventById(this.widget._id);
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.future,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Event event = snapshot.data;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 10.0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.taskname,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width,
                  color: event.status,
                ),
              ],
            ),
            content: Container(
              height: 500,
              padding: EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Descrição:",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(event.taskname),
                    ),
                    Container(
                      height: 2,
                      margin: EdgeInsets.only(bottom: 30),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    ),
                    Text(
                      "Escala:",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: TableSchedule(event.tasks),
                    ),
                    Container(
                      height: 2,
                      margin: EdgeInsets.only(bottom: 30),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    ),
                    Text(
                      "Comentários:",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: EventComments(
                        event.comments,
                        this._controller,
                        event.id,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
