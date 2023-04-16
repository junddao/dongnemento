// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelUser _$ModelUserFromJson(Map<String, dynamic> json) => ModelUser(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      introduce: json['introduce'] as String?,
      profileImage: json['profileImage'] as String?,
      password: json['password'] as String?,
      isBlocked: json['isBlocked'] as bool?,
      social: json['social'] as String?,
      pushEnabled: json['pushEnabled'] as bool?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      address: json['address'] as String?,
      blockedUserIds: (json['blockedUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ModelUserToJson(ModelUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'introduce': instance.introduce,
      'profileImage': instance.profileImage,
      'password': instance.password,
      'isBlocked': instance.isBlocked,
      'social': instance.social,
      'pushEnabled': instance.pushEnabled,
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'blockedUserIds': instance.blockedUserIds,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
