// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestUpdate _$ModelRequestUpdateFromJson(Map<String, dynamic> json) =>
    ModelRequestUpdate(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      introduce: json['introduce'] as String?,
      profileImage: json['profileImage'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      address: json['address'] as String?,
      social: json['social'] as String?,
      pushEnabled: json['pushEnabled'] as bool?,
    );

Map<String, dynamic> _$ModelRequestUpdateToJson(ModelRequestUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'introduce': instance.introduce,
      'profileImage': instance.profileImage,
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'social': instance.social,
      'pushEnabled': instance.pushEnabled,
    };
