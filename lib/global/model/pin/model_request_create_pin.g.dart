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
      'images': instance.images,
    };
