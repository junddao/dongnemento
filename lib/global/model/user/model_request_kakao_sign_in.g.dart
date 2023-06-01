// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_kakao_sign_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestKakaoSignIn _$ModelRequestKakaoSignInFromJson(
        Map<String, dynamic> json) =>
    ModelRequestKakaoSignIn(
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String,
      firebaseToken: json['firebaseToken'] as String,
    );

Map<String, dynamic> _$ModelRequestKakaoSignInToJson(
        ModelRequestKakaoSignIn instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'firebaseToken': instance.firebaseToken,
    };
