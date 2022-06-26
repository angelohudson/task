import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task/guard/login.dart';
import 'package:task/page/login/login_page.dart';
import 'package:task/page/navegation/navigation_home_screen.dart';
import 'package:task/page/screen/load.dart';
import 'package:task/app/shared/utils/connection.dart';
import 'package:task/service/notification/firebase_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          getToken();
          firebaseMessagingForeground();
          firebaseMessagingBackground();
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Task',
            theme: ThemeData(
              primaryColor: Color(0xffffc600),
            ),
            localizationsDelegates: [GlobalMaterialLocalizations.delegate],
            supportedLocales: [const Locale('pt')],
            routes: <String, WidgetBuilder>{
              '/': (context) => LoginGuard(NavigationHomeScreen()),
              '/login': (context) => LoginPage(),
            },
          );
        }
        return LoadScreenApp();
      },
    );
  }
}
