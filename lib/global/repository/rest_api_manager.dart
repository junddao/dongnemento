import 'package:base_project/global/repository/rest_client.dart';
import 'package:base_project/global/repository/token_interceptor.dart';
import 'package:dio/dio.dart';

import '../util/util.dart';

class RestApiManager {
  static final RestApiManager instance = RestApiManager._internal();
  factory RestApiManager() => instance;
  RestApiManager._internal();

  RestClient getRestClient() {
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(TokenInterceptor(RestClient(dio)));
    return RestClient(dio, baseUrl: endPoint);
  }
}
