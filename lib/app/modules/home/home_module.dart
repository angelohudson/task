import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/app/modules/home/home_page.dart';
import 'package:task/app/shared/service/token.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => TokenService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (_, args) => HomePage(),
        )
      ];
}
