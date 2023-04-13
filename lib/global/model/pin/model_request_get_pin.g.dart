// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_get_pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestGetPin _$ModelRequestGetPinFromJson(Map<String, dynamic> json) =>
    ModelRequestGetPin(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      range: json['range'] as int? ?? 2000,
    );

Map<String, dynamic> _$ModelRequestGetPinToJson(ModelRequestGetPin instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'range': instance.range,
    };
