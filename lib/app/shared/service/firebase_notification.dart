import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<String> getToken() async {
  String token = await messaging.getToken(
    vapidKey:
        "BHvJXax2f3egqWk3EQMJsvJ_Ub6BWgfmTogZXPQDGynSHzVOmhDYJK53a-0nO7dtKro_F3HQN_PYN7tHfJBmatc",
  );
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
