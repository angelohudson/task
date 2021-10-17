import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/page/login/login_page.dart';
import 'package:task/page/screen/load.dart';
import 'package:task/service/http/token.dart';

class LoginGuard extends StatelessWidget {
  final Widget _widget;

  LoginGuard(this._widget);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: verifyAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data) {
            return this._widget;
          } else {
            return LoginPage();
          }
        } else {
          return LoadScreenScaffold();
        }
      },
    );
  }

  Future<bool> verifyAuth() async {
    TokenService service = TokenService();
    SharedPreferences value = await SharedPreferences.getInstance();
    if (value.getString("email") != null) {
      List rules = await service.login(
        value.getString("email"),
        value.getString("password"),
      );
      return rules != null;
    }
    return false;
  }
}
