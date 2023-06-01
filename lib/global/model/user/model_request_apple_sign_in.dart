import 'package:json_annotation/json_annotation.dart';

part 'model_request_apple_sign_in.g.dart';

@JsonSerializable()
class ModelRequestAppleSignIn {
  String idToken;
  String firebaseToken;
  ModelRequestAppleSignIn({
    required this.idToken,
    required this.firebaseToken,
  });

  factory ModelRequestAppleSignIn.fromJson(Map<String, dynamic> json) => _$ModelRequestAppleSignInFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestAppleSignInToJson(this);
}
