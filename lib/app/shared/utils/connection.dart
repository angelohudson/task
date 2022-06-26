import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:task/service/http/interceptors/authoriation_interceptor.dart';
import '../../../service/http/interceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor(), AuthorizationInterceptor()],
);

String baseUrl = '192.168.1.107:8080';

final navigatorKey = GlobalKey<NavigatorState>();
