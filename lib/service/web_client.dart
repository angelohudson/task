import 'dart:async';
import 'package:task/app/shared/utils/connection.dart';
import 'package:task/service/http/token.dart';
import 'package:http/http.dart';

import '../app/shared/utils/connection.dart';

abstract class WebClient<T> {
  final TokenService _token = TokenService();
  Future<T> findOne(int id);
  Future<List<T>> findAll();
  Future<dynamic> save(T user);
  Future<dynamic> update(T user);
  Future<bool> delete(int id);

  Future<Response> getEntity({String path = "", Map<String, dynamic> queryParameters}) async {
    return client.get(Uri.http(baseUrl, path, queryParameters), headers: {
      'Authorization': (await (this)._token.getBearerToken()),
      'Content-type': 'application/json',
    }).timeout(Duration(seconds: 15));
  }

  Future<Response> postEntity(body, {String path = ""}) async {
    return client.post(Uri.http(baseUrl, path), body: body, headers: {
      'Authorization': (await (this)._token.getBearerToken()),
      'Content-type': 'application/json',
    }).timeout(Duration(seconds: 15));
  }

  Future<Response> updateEntity(body, {String path = ""}) async {
    return client.put(Uri.http(baseUrl, path), body: body, headers: {
      'Authorization': (await (this)._token.getBearerToken()),
      'Content-type': 'application/json',
    }).timeout(Duration(seconds: 15));
  }

  Future<Response> deleteEntity({String path = ""}) async {
    return client.delete(Uri.http(baseUrl, path), headers: {
      'Authorization': (await (this)._token.getBearerToken()),
      'Content-type': 'application/json',
    }).timeout(Duration(seconds: 60));
  }
}
