import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/app/shared/service/firebase_notification.dart';
import 'package:task/app/shared/utils/connection.dart';

class TokenService {
  FirebaseService _firebaseService = new FirebaseService();

  Future<String> login(String cpf, String password) async {
    try {
      final Response response = await client
          .post(Uri.http(baseUrl, "/auth-api/login"), headers: {
        'Content-type': 'application/x-www-form-urlencoded'
      }, body: {
        "userName": cpf,
        "password": password
      }).timeout(Duration(seconds: 15));

      String token =
          response.headers['authorization'].replaceAll("Bearer", "").trim();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', token);

      return token;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> launchDeviceToken() async {
    final Response response = await client
        .post(Uri.http(baseUrl, "/core-api/auth/device-token"),
            headers: {
              'Authorization': (await (this.getBearerToken())),
              'Content-type': 'application/json',
            },
            body: jsonEncode({'token': (await _firebaseService.getToken())}))
        .timeout(Duration(seconds: 60));
    return jsonDecode(response.body);
  }

  Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    return true;
  }

  Future<String> getBearerToken() async {
    return "Bearer " + await this._getString('token');
  }

  Future<bool> hasToken() async {
    return await this._getString('token') != null;
  }

  Future<String> _getString(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) != null ? pref.getString(key) : "";
  }

  Future<dynamic> getMe() async {
    String token = await this.getBearerToken();
    final Response response = await client.get(
        Uri.http(baseUrl, "/core-api/auth/me"),
        headers: {"Authorization": token});
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getAuthorities() async {
    final dynamic me = getMe();

    return me['roles'];
  }
}
