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
      category: $enumDecode(_$CategoryTypeEnumMap, json['category']),
      categoryScore: json['categoryScore'] as int,
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
      'category': _$CategoryTypeEnumMap[instance.category]!,
      'categoryScore': instance.categoryScore,
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

const _$CategoryTypeEnumMap = {
  CategoryType.daily: 'DAILY',
  CategoryType.mart: 'MART',
  CategoryType.hairShop: 'HAIR_SHOP',
  CategoryType.restaurant: 'RESTAURANT',
  CategoryType.cafe: 'CAFE',
  CategoryType.hotel: 'HOTEL',
  CategoryType.pension: 'PENSION',
};
