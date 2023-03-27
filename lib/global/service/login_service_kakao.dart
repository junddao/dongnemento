import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;

class LoginServiceKakao {
  static final LoginServiceKakao _instance = LoginServiceKakao._internal();

  factory LoginServiceKakao() {
    return _instance;
  }

  LoginServiceKakao._internal() {
    // do something
  }

  Future<kakao.User?> login() async {
    bool result = await loginWithKakaoTalk();
    if (result) {
      kakao.User? user = await kakao.UserApi.instance.me();
      return user;
    }
    return null;
  }

  Future<bool> loginWithKakaoTalk() async {
    if (await kakao.isKakaoTalkInstalled()) {
      try {
        await kakao.UserApi.instance.loginWithKakaoTalk();

        return true;
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await kakao.UserApi.instance.loginWithKakaoAccount();

          return true;
        } catch (error) {
          return false;
        }
      }
    } else {
      try {
        await kakao.UserApi.instance.loginWithKakaoAccount();

        return true;
      } catch (error) {
        return false;
      }
    }
  }

  Future<bool> logOut() async {
    try {
      await kakao.UserApi.instance.logout();

      return true;
    } catch (error) {
      return false;
    }
  }
}
