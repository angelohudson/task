import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task/page/login/login_page.dart';
import 'package:task/page/screen/load.dart';
import 'package:task/service/notification/firebase_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      theme: ThemeData(
        primaryColor: Color(0xffffc600),
      ),
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('pt')],
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            getToken();
            firebaseMessagingForeground();
            firebaseMessagingBackground();
            return LoginPage();
          }
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
                  child: LoadScreen()),
            ),
          );
        },
      ),
    );
  }
}
