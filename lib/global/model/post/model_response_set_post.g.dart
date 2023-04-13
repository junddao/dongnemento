// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_response_set_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelLocation _$ModelLocationFromJson(Map<String, dynamic> json) =>
    ModelLocation(
      address: json['address'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ModelLocationToJson(ModelLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };
