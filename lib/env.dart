import 'package:flutter/foundation.dart';

enum OpMode {
  unknown,
  dev,
  prod,
}

const _prodApiBaseUrl = 'http://43.200.119.214/prod';
const _prodApiAuthUrl = '$_prodApiBaseUrl$_apiAuth';
const _prodApiMapUrl = '$_prodApiBaseUrl$_apiMap';
const _prodApiPinUrl = '$_prodApiBaseUrl$_apiPin';
const _prodApiPinReplyUrl = '$_prodApiBaseUrl$_apiPinReply';
const _prodApiLikeUrl = '$_prodApiBaseUrl$_apiLike';
const _prodApiHateUrl = '$_prodApiBaseUrl$_apiHate';
const _prodApiReportUrl = '$_prodApiBaseUrl$_apiReport';

// const _devApiBaseUrl = 'http://192.168.1.82:17008'; // 06
// const _devApiBaseUrl = 'http://192.168.1.47:17008'; // 05
// const _devApiBaseUrl = 'http://43.200.119.214/prod_api'; // aws
const _devApiBaseUrl = 'http://43.200.119.214/dev'; // aws
// const _devApiBaseUrl = 'http://192.168.2.40:17009'; // theego
// const _devApiBaseUrl = 'http://192.168.0.100:17008'; // home

const _devApiAuthUrl = '$_devApiBaseUrl$_apiAuth';
const _devApiMapUrl = '$_devApiBaseUrl$_apiMap';
const _devApiPinUrl = '$_devApiBaseUrl$_apiPin';
const _devApiPinReplyUrl = '$_devApiBaseUrl$_apiPinReply';
const _devApiLikeUrl = '$_devApiBaseUrl$_apiLike';
const _devApiHateUrl = '$_devApiBaseUrl$_apiHate';
const _devApiReportUrl = '$_devApiBaseUrl$_apiReport';

const _apiAuth = '/user';
const _apiMap = '/map';
const _apiPin = '/pin';
const _apiPinReply = '/reply';
const _apiLike = '/like';
const _apiHate = '/hate';
const _apiReport = '/report';

class Env {
  static Env? _instance;

  static late OpMode _mode;
  static late String _apiBaseUrl;
  static late String _apiAuthUrl;
  static late String _apiMapUrl;
  static late String _apiPinUrl;
  static late String _apiPinReplyUrl;
  static late String _apiLikeUrl;
  static late String _apiHateUrl;
  static late String _apiReportUrl;

  /// User API 접속 주소
  static String get apiBaseUrl => _apiBaseUrl;
  static String get apiAuthUrl => _apiAuthUrl;
  static String get apiMapUrl => _apiMapUrl;
  static String get apiPinUrl => _apiPinUrl;
  static String get apiPinReplyUrl => _apiPinReplyUrl;
  static String get apiLikeUrl => _apiLikeUrl;
  static String get apiHateUrl => _apiHateUrl;
  static String get apiReportUrl => _apiReportUrl;

  //End Point
  static OpMode get opMode => _mode;

  factory Env() {
    _instance ??= Env._internal();
    return _instance!;
  }
  Env._internal() {
    if (kDebugMode) {
      _mode = OpMode.dev;
    } else {
      _mode = OpMode.prod;
    }

    changeMode(_mode);
  }

  static void changeMode(OpMode mode) {
    _mode = mode;

    switch (mode) {
      case OpMode.prod: //운영 모드
        _apiBaseUrl = _prodApiBaseUrl;
        _apiAuthUrl = _prodApiAuthUrl;
        _apiMapUrl = _prodApiMapUrl;
        _apiPinUrl = _prodApiPinUrl;
        _apiPinReplyUrl = _prodApiPinReplyUrl;
        _apiLikeUrl = _prodApiLikeUrl;
        _apiHateUrl = _prodApiHateUrl;
        _apiReportUrl = _prodApiReportUrl;

        break;
      case OpMode.dev: //개발 모드
        _apiBaseUrl = _devApiBaseUrl;
        _apiAuthUrl = _devApiAuthUrl;
        _apiMapUrl = _devApiMapUrl;
        _apiPinUrl = _devApiPinUrl;
        _apiPinReplyUrl = _devApiPinReplyUrl;
        _apiLikeUrl = _devApiLikeUrl;
        _apiHateUrl = _devApiHateUrl;
        _apiReportUrl = _devApiReportUrl;

        break;
      case OpMode.unknown:
      default:
        _apiAuthUrl = '';
        _apiMapUrl = '';
        break;
    }
  }
}
