import 'package:json_annotation/json_annotation.dart';

part 'model_request_sign_up.g.dart';

@JsonSerializable()
class ModelRequestSignUp {
  String social;
  String email;
  String name;
  String password;
  String? profileImage;
  double? lat;
  double? lng;
  String? address;
  ModelRequestSignUp({
    required this.social,
    required this.email,
    required this.name,
    required this.password,
    this.profileImage,
    this.lat,
    this.lng,
    required this.address,
  });

  factory ModelRequestSignUp.fromJson(Map<String, dynamic> json) => _$ModelRequestSignUpFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestSignUpToJson(this);
}
