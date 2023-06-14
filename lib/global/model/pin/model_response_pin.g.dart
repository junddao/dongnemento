// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_response_pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelResponsePin _$ModelResponsePinFromJson(Map<String, dynamic> json) =>
    ModelResponsePin(
      id: json['id'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      title: json['title'] as String?,
      isUserBlocked: json['isUserBlocked'] as bool?,
      replyCount: json['replyCount'] as int?,
      body: json['body'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: $enumDecode(_$CategoryTypeEnumMap, json['category']),
      categoryScore: json['categoryScore'] as int,
      userId: json['userId'] as String,
      userName: json['userName'] as String?,
      userProfileImage: json['userProfileImage'] as String?,
      likeCount: json['likeCount'] as int?,
      isLiked: json['isLiked'] as bool?,
      hateCount: json['hateCount'] as int?,
      isHated: json['isHated'] as bool?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ModelResponsePinToJson(ModelResponsePin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'lng': instance.lng,
      'title': instance.title,
      'isUserBlocked': instance.isUserBlocked,
      'replyCount': instance.replyCount,
      'body': instance.body,
      'images': instance.images,
      'category': _$CategoryTypeEnumMap[instance.category]!,
      'categoryScore': instance.categoryScore,
      'userId': instance.userId,
      'userName': instance.userName,
      'userProfileImage': instance.userProfileImage,
      'likeCount': instance.likeCount,
      'isLiked': instance.isLiked,
      'hateCount': instance.hateCount,
      'isHated': instance.isHated,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
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
