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
      authorId: json['authorId'] as String?,
      targetId: json['targetId'] as String?,
    );

Map<String, dynamic> _$FirebaseModelToJson(FirebaseModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
      'authorId': instance.authorId,
      'targetId': instance.targetId,
    };