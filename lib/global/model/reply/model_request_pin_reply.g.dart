// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_pin_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestPinReply _$ModelRequestPinReplyFromJson(
        Map<String, dynamic> json) =>
    ModelRequestPinReply(
      pinId: json['pinId'] as String,
      targetReplyId: json['targetReplyId'] as String?,
      reply: json['reply'] as String,
    );

Map<String, dynamic> _$ModelRequestPinReplyToJson(
        ModelRequestPinReply instance) =>
    <String, dynamic>{
      'pinId': instance.pinId,
      'targetReplyId': instance.targetReplyId,
      'reply': instance.reply,
    };
