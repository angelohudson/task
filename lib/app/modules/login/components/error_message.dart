import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoginError(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 10.0,
        title: Text(
          'Erro',
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Text(
              'Erro! Por favor verifique seus dados e tente novamente.',
            ),
          ),
        ),
        actions: <Widget>[
          new TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
