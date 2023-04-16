import 'package:json_annotation/json_annotation.dart';

part 'model_request_apple_sign_in.g.dart';

@JsonSerializable()
class ModelRequestAppleSignIn {
  String idToken;
  ModelRequestAppleSignIn({
    required this.idToken,
  });

  factory ModelRequestAppleSignIn.fromJson(Map<String, dynamic> json) => _$ModelRequestAppleSignInFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestAppleSignInToJson(this);
}
