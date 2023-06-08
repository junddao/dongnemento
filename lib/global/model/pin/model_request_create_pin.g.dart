// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_create_pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestCreatePin _$ModelRequestCreatePinFromJson(
        Map<String, dynamic> json) =>
    ModelRequestCreatePin(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      title: json['title'] as String,
      body: json['body'] as String?,
      category: $enumDecode(_$CategoryTypeEnumMap, json['category']),
      categoryScore: json['categoryScore'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ModelRequestCreatePinToJson(
        ModelRequestCreatePin instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'title': instance.title,
      'body': instance.body,
      'category': _$CategoryTypeEnumMap[instance.category]!,
      'categoryScore': instance.categoryScore,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'images': instance.images,
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
