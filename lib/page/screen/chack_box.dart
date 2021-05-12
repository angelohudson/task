import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputChackBox extends StatefulWidget {
  final String id;
  final String text;
  final String subtitle;
  final Function onChange;
  final bool val;

  InputChackBox({this.id, this.val, this.text, this.subtitle, this.onChange});
  
  _InputChackBoxState createState() => _InputChackBoxState();
}

class _InputChackBoxState extends State<InputChackBox> {
  @override
  Widget build(BuildContext context) {
    return new CheckboxListTile(
      value: this.widget.val,
      onChanged: (bool val) {
        setState(() {
          this.widget.onChange(this.widget.id, val);
        });
      },
      title: new Text(this.widget.text),
      controlAffinity: ListTileControlAffinity.leading,
      subtitle: new Text(this.widget.subtitle),
      secondary: new Icon(Icons.archive),
      activeColor: Colors.red,
    );
  }
}
