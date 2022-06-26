import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/app/shared/service/firebase_notification.dart';
import 'package:task/app/shared/service/token.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseService _firebaseService = Modular.get();
  final TokenService tokenService = TokenService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.tokenService.hasToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          this._firebaseService.getToken();
          this._firebaseService.firebaseMessagingForeground();
          this._firebaseService.firebaseMessagingBackground();
          if (snapshot.data)
            Modular.to.pushReplacementNamed("/home");
          else
            Modular.to.pushReplacementNamed('/login');
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
