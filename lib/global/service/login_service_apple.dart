import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginServiceApple {
  static final LoginServiceApple _instance = LoginServiceApple._internal();

  factory LoginServiceApple() {
    return _instance;
  }

  LoginServiceApple._internal() {
    // do something
  }

  Future<String?> login() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    return credential.identityToken;
  }

  Future<bool> logOut() async {
    try {
      // await kakao.UserApi.instance.logout();

      return true;
    } catch (error) {
      return false;
    }
  }
}
