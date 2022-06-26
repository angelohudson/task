import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/app/modules/home/components/list_task/event_details/event_details_controller.dart';
import 'package:task/app/modules/home/model/event.dart';
import 'package:task/app/shared/components/text_input_field.dart';

class EventComments extends StatefulWidget {
  final List<Comment> comments;
  final int eventId;
  final EventDetailsController _controller;
  EventComments(this.comments, this._controller, this.eventId);

  @override
  State<StatefulWidget> createState() => _EventCommentsState(this.comments);
}

class _EventCommentsState extends State<EventComments> {
  final List<Comment> comments;
  final TextEditingController _textController = new TextEditingController();

  _EventCommentsState(this.comments);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: this
              .comments
              .map<Widget>((comment) => CommentScreen(comment))
              .toList(),
        ),
        TextInputFieldComponent(
          _textController,
          Icon(Icons.title),
          'Digite um Comentário...',
          _validateCamp,
          TextInputType.text,
          onEditingComplete: onEditingComplete,
        ),
      ]),
    );
  }

  void onEditingComplete() {
    setState(() {
      this
          .widget
          ._controller
          .addComment(this.widget.eventId, this._textController.text);
      this.comments.add(new Comment("Eu", this._textController.text));
      this._textController.text = "";
    });
  }

  String _validateCamp(String value) {
    return value.trim().isEmpty ? "Preencha o campo acima!" : null;
  }
}

class CommentScreen extends StatelessWidget {
  final Comment comment;

  CommentScreen(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "${this.comment.memberName}:",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
        ),
        Text(
          this.comment.text,
          style: TextStyle(fontSize: 15),
        ),
      ]),
    );
  }
}
