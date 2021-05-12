import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

showCustomDialog(
  BuildContext context,
  String title,
  String message,
  Color color,
  Function onConfirm,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              color: color,
            ),
          ],
        ),
        content: Container(
          height: 220,
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Container(
              child: Text(message),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Row(
              children: [
                Text(
                  "Confirmar",
                ),
              ],
            ),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
