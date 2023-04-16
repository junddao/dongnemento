// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_sign_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestSignIn _$ModelRequestSignInFromJson(Map<String, dynamic> json) =>
    ModelRequestSignIn(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$ModelRequestSignInToJson(ModelRequestSignIn instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
