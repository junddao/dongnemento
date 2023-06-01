// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_apple_sign_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestAppleSignIn _$ModelRequestAppleSignInFromJson(
        Map<String, dynamic> json) =>
    ModelRequestAppleSignIn(
      idToken: json['idToken'] as String,
      firebaseToken: json['firebaseToken'] as String,
    );

Map<String, dynamic> _$ModelRequestAppleSignInToJson(
        ModelRequestAppleSignIn instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'firebaseToken': instance.firebaseToken,
    };
