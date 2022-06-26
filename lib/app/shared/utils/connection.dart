import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:task/app/shared/interceptors/authoriation_interceptor.dart';
import 'package:task/app/shared/interceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor(), AuthorizationInterceptor()],
);

String baseUrl = '192.168.1.107:8080';

final navigatorKey = GlobalKey<NavigatorState>();
