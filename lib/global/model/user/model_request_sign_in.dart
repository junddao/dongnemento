import 'package:json_annotation/json_annotation.dart';

part 'model_request_sign_in.g.dart';

@JsonSerializable()
class ModelRequestSignIn {
  String email;
  String password;
  String firebaseToken;
  ModelRequestSignIn({
    required this.email,
    required this.password,
    required this.firebaseToken,
  });

  factory ModelRequestSignIn.fromJson(Map<String, dynamic> json) => _$ModelRequestSignInFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestSignInToJson(this);
}
