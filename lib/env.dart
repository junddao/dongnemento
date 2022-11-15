import 'package:base_project/env/environment.dart';

enum OpMode {
  unknown,
  dev,
  product,
}

const _prodApiBaseUrl = 'http://43.200.119.214';
const _prodApiAuthUrl = '$_prodApiBaseUrl$_apiAuth';
const _prodApiMapUrl = '$_prodApiBaseUrl$_apiMap';
const _prodApiPinUrl = '$_prodApiBaseUrl$_apiPin';
const _prodApiPinReplyUrl = '$_prodApiBaseUrl$_apiPinReply';
const _prodApiLikeUrl = '$_prodApiBaseUrl$_apiLike';

const _devApiBaseUrl = 'http://192.168.1.82:17008'; // 06
// const _devApiBaseUrl = 'http://192.168.1.47:17008';  // 05

const _devApiAuthUrl = '$_devApiBaseUrl$_apiAuth';
const _devApiMapUrl = '$_devApiBaseUrl$_apiMap';
const _devApiPinUrl = '$_devApiBaseUrl$_apiPin';
const _devApiPinReplyUrl = '$_devApiBaseUrl$_apiPinReply';
const _devApiLikeUrl = '$_devApiBaseUrl$_apiLike';

const _apiAuth = '/user';
const _apiMap = '/map';
const _apiPin = '/pin';
const _apiPinReply = '/reply';
const _apiLike = '/like';

class Env {
  static Env? _instance;

  static late OpMode _mode;
  static late String _apiBaseUrl;
  static late String _apiAuthUrl;
  static late String _apiMapUrl;
  static late String _apiPinUrl;
  static late String _apiPinReplyUrl;
  static late String _apiLikeUrl;

  /// User API 접속 주소
  static String get apiBaseUrl => _apiBaseUrl;
  static String get apiAuthUrl => _apiAuthUrl;
  static String get apiMapUrl => _apiMapUrl;
  static String get apiPinUrl => _apiPinUrl;
  static String get apiPinReplyUrl => _apiPinReplyUrl;
  static String get apiLikeUrl => _apiLikeUrl;

  //End Point
  static OpMode get opMode => _mode;

  factory Env() {
    _instance ??= Env._internal();
    return _instance!;
  }

  // Env._internal() {
  //   //Product API EndPoint (주의 실제 운영 중인 API EndPoint)
  //   if (kReleaseMode) _mode = OpMode.product;
  //   //QA API EndPoint
  //   // if (kProfileMode) _mode = OpMode.STAGING;
  //   //개발 API EndPoint
  //   if (kDebugMode) _mode = OpMode.dev;

  //   changeMode(_mode);
  // }
  Env._internal() {
    if (Environment.buildType == BuildType.dev) {
      _mode = OpMode.dev;
    } else if (Environment.buildType == BuildType.prod) {
      _mode = OpMode.product;
    } else {
      _mode = OpMode.dev;
    }

    changeMode(_mode);
  }

  static void changeMode(OpMode mode) {
    _mode = mode;

    switch (mode) {
      case OpMode.product: //운영 모드
        _apiBaseUrl = _prodApiBaseUrl;
        _apiAuthUrl = _prodApiAuthUrl;
        _apiMapUrl = _prodApiMapUrl;
        _apiPinUrl = _prodApiPinUrl;
        _apiPinReplyUrl = _prodApiPinReplyUrl;
        _apiLikeUrl = _prodApiLikeUrl;
        break;
      case OpMode.dev: //개발 모드
        _apiBaseUrl = _devApiBaseUrl;
        _apiAuthUrl = _devApiAuthUrl;
        _apiMapUrl = _devApiMapUrl;
        _apiPinUrl = _devApiPinUrl;
        _apiPinReplyUrl = _devApiPinReplyUrl;
        _apiLikeUrl = _devApiLikeUrl;
        break;
      case OpMode.unknown:
      default:
        _apiAuthUrl = '';
        _apiMapUrl = '';
        break;
    }
  }
}
