import 'package:http_interceptor/http_interceptor.dart';
import 'package:task/app/shared/utils/connection.dart';

class AuthorizationInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (data.statusCode == 401) {
      navigatorKey.currentState
          .pushNamedAndRemoveUntil("/login", (route) => false);
      return null;
    } else {
      return data;
    }
  }
}
