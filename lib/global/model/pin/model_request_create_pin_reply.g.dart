// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_create_pin_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestCreatePinReply _$ModelRequestCreatePinReplyFromJson(
        Map<String, dynamic> json) =>
    ModelRequestCreatePinReply(
      pinId: json['pinId'] as String?,
      reply: json['reply'] as String?,
      targetReplyId: json['targetReplyId'] as String?,
    );

Map<String, dynamic> _$ModelRequestCreatePinReplyToJson(
        ModelRequestCreatePinReply instance) =>
    <String, dynamic>{
      'pinId': instance.pinId,
      'reply': instance.reply,
      'targetReplyId': instance.targetReplyId,
    };
