import 'package:flutter/foundation.dart';

enum OpMode {
  unknown,
  dev,
  product,
}

const _prodApiBaseUrl = "https://api.dingdongu.com";
const _prodApiAuthUrl = "$_prodApiBaseUrl$_apiAuth";
const _prodApiAccountUrl = "$_prodApiBaseUrl$_apiAccount";

const _devApiBaseUrl = "https://dev-api.dingdongu.com";
const _devApiAuthUrl = "$_devApiBaseUrl$_apiAuth";
const _devApiAccountUrl = "$_devApiBaseUrl$_apiAccount";

const _apiAuth = "/auth";
const _apiAccount = "/accounts";

class Env {
  static Env? _instance;

  static late OpMode _mode;
  static late String _apiAuthUrl;
  static late String _apiAccountUrl;

  /// User API 접속 주소
  static String get apiAuthUrl => _apiAuthUrl;
  static String get apiAccountUrl => _apiAccountUrl;

  //End Point
  static OpMode get opMode => _mode;

  factory Env() {
    _instance ??= Env._internal();
    return _instance!;
  }

  Env._internal() {
    //Product API EndPoint (주의 실제 운영 중인 API EndPoint)
    if (kReleaseMode) _mode = OpMode.product;
    //QA API EndPoint
    // if (kProfileMode) _mode = OpMode.STAGING;
    //개발 API EndPoint
    if (kDebugMode) _mode = OpMode.dev;

    changeMode(_mode);
  }

  static void changeMode(OpMode mode) {
    _mode = mode;

    switch (mode) {
      case OpMode.product: //운영 모드
        _apiAuthUrl = _prodApiAuthUrl;
        _apiAccountUrl = _prodApiAccountUrl;
        break;
      case OpMode.dev: //개발 모드
        _apiAuthUrl = _devApiAuthUrl;
        _apiAccountUrl = _devApiAccountUrl;
        break;
      case OpMode.unknown:
      default:
        _apiAuthUrl = "";
        _apiAccountUrl = "";
        break;
    }
  }
}
