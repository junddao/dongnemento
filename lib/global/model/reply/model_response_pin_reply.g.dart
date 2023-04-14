// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_response_pin_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelResponsePinReply _$ModelResponsePinReplyFromJson(
        Map<String, dynamic> json) =>
    ModelResponsePinReply(
      id: json['id'] as String,
      pinId: json['pinId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      targetReplyId: json['targetReplyId'] as String?,
      reply: json['reply'] as String,
      likeCount: json['likeCount'] as int?,
      isLiked: json['isLiked'] as bool?,
      hateCount: json['hateCount'] as int?,
      isHated: json['isHated'] as bool?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$ModelResponsePinReplyToJson(
        ModelResponsePinReply instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pinId': instance.pinId,
      'userId': instance.userId,
      'userName': instance.userName,
      'targetReplyId': instance.targetReplyId,
      'reply': instance.reply,
      'likeCount': instance.likeCount,
      'isLiked': instance.isLiked,
      'hateCount': instance.hateCount,
      'isHated': instance.isHated,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
