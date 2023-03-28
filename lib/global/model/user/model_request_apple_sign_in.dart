import 'dart:convert';

class ModelRequestAppleSignIn {
  String idToken;
  ModelRequestAppleSignIn({
    required this.idToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idToken': idToken,
    };
  }

  factory ModelRequestAppleSignIn.fromMap(Map<String, dynamic> map) {
    return ModelRequestAppleSignIn(
      idToken: map['idToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestAppleSignIn.fromJson(String source) => ModelRequestAppleSignIn.fromMap(json.decode(source));

  ModelRequestAppleSignIn copyWith({
    String? idToken,
  }) {
    return ModelRequestAppleSignIn(
      idToken: idToken ?? this.idToken,
    );
  }
}
