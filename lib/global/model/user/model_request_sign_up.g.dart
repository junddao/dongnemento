// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestSignUp _$ModelRequestSignUpFromJson(Map<String, dynamic> json) =>
    ModelRequestSignUp(
      social: json['social'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      profileImage: json['profileImage'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      address: json['address'] as String?,
      firebaseToken: json['firebaseToken'] as String,
    );

Map<String, dynamic> _$ModelRequestSignUpToJson(ModelRequestSignUp instance) =>
    <String, dynamic>{
      'social': instance.social,
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'profileImage': instance.profileImage,
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'firebaseToken': instance.firebaseToken,
    };
