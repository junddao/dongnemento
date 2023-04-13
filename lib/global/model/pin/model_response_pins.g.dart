// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_response_pins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelResponsePins _$ModelResponsePinsFromJson(Map<String, dynamic> json) =>
    ModelResponsePins(
      id: json['id'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      isUserBlocked: json['isUserBlocked'] as bool,
      likeCount: json['likeCount'] as int?,
      isLiked: json['isLiked'] as bool?,
      replyCount: json['replyCount'] as int,
      title: json['title'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      body: json['body'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ModelResponsePinsToJson(ModelResponsePins instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'userId': instance.userId,
      'userName': instance.userName,
      'isUserBlocked': instance.isUserBlocked,
      'likeCount': instance.likeCount,
      'isLiked': instance.isLiked,
      'replyCount': instance.replyCount,
      'title': instance.title,
      'images': instance.images,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
