import 'dart:convert';

class SignOutResult {
  SignOut signOut;
  SignOutResult({
    required this.signOut,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signOut': signOut.toMap(),
    };
  }

  factory SignOutResult.fromMap(Map<String, dynamic> map) {
    return SignOutResult(
      signOut: SignOut.fromMap(map['signOut']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SignOutResult.fromJson(String source) => SignOutResult.fromMap(json.decode(source));
}

class SignOut {
  bool success;
  String? detail;
  SignOut({
    required this.success,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'detail': detail,
    };
  }

  factory SignOut.fromMap(Map<String, dynamic> map) {
    return SignOut(
      success: map['success'],
      detail: map['detail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignOut.fromJson(String source) => SignOut.fromMap(json.decode(source));
}
