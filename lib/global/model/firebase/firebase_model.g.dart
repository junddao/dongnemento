// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseModel _$FirebaseModelFromJson(Map<String, dynamic> json) =>
    FirebaseModel(
      title: json['title'] as String?,
      body: json['body'] as String?,
      imageUrl: json['imageUrl'] as String?,
      badge: json['badge'] as String?,
    );

Map<String, dynamic> _$FirebaseModelToJson(FirebaseModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
      'badge': instance.badge,
    };
