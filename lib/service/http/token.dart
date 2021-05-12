import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/service/http/connection.dart';
import 'package:task/service/notification/firebase_notification.dart';

class TokenService {
  Future<List<dynamic>> login(String email, String password) async {
    try {
      final Response response =
          await client.get(Uri.http(baseUrl, "auth/authorities"), headers: {
        'Authorization': (await this._getBase64Encode(email + ":" + password)),
        'Content-type': 'application/json',
      }).timeout(Duration(seconds: 15));

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('email', email);
      pref.setString('password', password);

      await this.launchDeviceToken();

      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> launchDeviceToken() async {
    final Response response = await client
        .post(Uri.http(baseUrl, "auth/device-token"),
            headers: {
              'Authorization': (await (this.getBase64())),
              'Content-type': 'application/json',
            },
            body: jsonEncode({'token': (await getToken())}))
        .timeout(Duration(seconds: 60));
    return jsonDecode(response.body);
  }

  Future<dynamic> getMe() async {
    final Response response =
        await client.get(Uri.http(baseUrl, "auth/me"), headers: {
      'Authorization': (await (this.getBase64())),
      'Content-type': 'application/json',
    }).timeout(Duration(seconds: 60));
    return jsonDecode(response.body);
  }

  Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('email');
    pref.remove('password');
    return true;
  }

  Future<String> getBase64() async {
    String email = await this._getString('email');
    String password = await this._getString('password');
    String credentials = email + ":" + password;
    return this._getBase64Encode(credentials);
  }

  Future<String> _getBase64Encode(String credentials) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return "Basic " + stringToBase64.encode(credentials);
  }

  Future<String> _getString(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) != null ? pref.getString(key) : "";
  }
}
