
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadScreen extends StatelessWidget {
  const LoadScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text('Loading'),
        ],
      ),
    );
  }
}
