import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadComponent extends StatelessWidget {
  const LoadComponent({
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

class LoadComponentScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: new GlobalKey<ScaffoldState>(),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.cyan[800],
                  Colors.cyan[400],
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: LoadComponent()),
      ),
    );
  }
}

class LoadComponentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      home: Scaffold(
        key: new GlobalKey<ScaffoldState>(),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height
                  : 775.0,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    Colors.cyan[800],
                    Colors.cyan[400],
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: LoadComponent()),
        ),
      ),
    );
  }
}
