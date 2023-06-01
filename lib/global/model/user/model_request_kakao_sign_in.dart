import 'package:json_annotation/json_annotation.dart';

part 'model_request_kakao_sign_in.g.dart';

@JsonSerializable()
class ModelRequestKakaoSignIn {
  String name;
  String email;
  String profileImage;
  String firebaseToken;
  ModelRequestKakaoSignIn({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.firebaseToken,
  });

  factory ModelRequestKakaoSignIn.fromJson(Map<String, dynamic> json) => _$ModelRequestKakaoSignInFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestKakaoSignInToJson(this);
}
