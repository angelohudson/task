import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/app/modules/home/home_module.dart';
import 'package:task/app/modules/login/login_module.dart';
import 'package:task/app/shared/service/firebase_notification.dart';
import 'package:task/app/shared/service/token.dart';
import 'package:task/app/splash/splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseService()),
        Bind((i) => TokenService())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (_, args) => SplashPage(),
        ),
        ModuleRoute(
          "/home",
          module: HomeModule(),
        ),
        ModuleRoute(
          "/login",
          module: LoginModule(),
        ),
      ];
}
