import 'package:flutter/foundation.dart';

enum OpMode {
  unknown,
  dev,
  product,
}

const _prodApiBaseUrl = "http://43.200.119.214";
const _prodApiAuthUrl = "$_prodApiBaseUrl$_apiAuth";

const _devApiBaseUrl = "http://192.168.1.82:17007";
const _devApiAuthUrl = "$_devApiBaseUrl$_apiAuth";

const _apiAuth = "/user";

class Env {
  static Env? _instance;

  static late OpMode _mode;
  static late String _apiAuthUrl;

  /// User API 접속 주소
  static String get apiAuthUrl => _apiAuthUrl;

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
        break;
      case OpMode.dev: //개발 모드
        _apiAuthUrl = _devApiAuthUrl;
        break;
      case OpMode.unknown:
      default:
        _apiAuthUrl = "";
        break;
    }
  }
}
