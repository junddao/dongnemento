// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_request_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelRequestBlock _$ModelRequestBlockFromJson(Map<String, dynamic> json) =>
    ModelRequestBlock(
      userId: json['userId'] as String,
      isBlocked: json['isBlocked'] as bool,
    );

Map<String, dynamic> _$ModelRequestBlockToJson(ModelRequestBlock instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isBlocked': instance.isBlocked,
    };
