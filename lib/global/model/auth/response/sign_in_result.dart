import 'dart:convert';

class SignInResult {
  SignIn signIn;
  SignInResult({
    required this.signIn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signIn': signIn.toMap(),
    };
  }

  factory SignInResult.fromMap(Map<String, dynamic> map) {
    return SignInResult(
      signIn: SignIn.fromMap(map['signIn']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInResult.fromJson(String source) => SignInResult.fromMap(json.decode(source));
}

class SignIn {
  String token;
  String refreshToken;
  String expiresIn;
  SignIn({
    required this.token,
    required this.refreshToken,
    required this.expiresIn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  factory SignIn.fromMap(Map<String, dynamic> map) {
    return SignIn(
      token: map['token'],
      refreshToken: map['refreshToken'],
      expiresIn: map['expiresIn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignIn.fromJson(String source) => SignIn.fromMap(json.decode(source));
}
