import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/app/modules/login/login_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        //ChildRoute(
        //  "/",
        //  child: (_, args) => SplashPage(),
        //),
        //ModuleRoute(
        //  "/cobranca",
        //  module: CobrancaModule(),
        //),
        //ModuleRoute(
        //  "/home",
        //  module: HomeModule(),
        //),
        //ModuleRoute(
        //  "/counter",
        //  module: CounterModule(),
        //),
        ModuleRoute(
          "/login",
          module: LoginModule(),
        ),
      ];
}
