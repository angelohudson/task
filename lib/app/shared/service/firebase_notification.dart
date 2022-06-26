import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:task/app/shared/utils/consts.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class FirebaseService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String> getToken() async {
    String token = await messaging.getToken(vapidKey: FIREBASE_MESSAGING_KEY);
    print("Token: $token");
    return token;
  }

  void firebaseMessagingForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print(message);
    });
  }

  void firebaseMessagingBackground() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Mensagem em background");
    print(message);
  }
}

