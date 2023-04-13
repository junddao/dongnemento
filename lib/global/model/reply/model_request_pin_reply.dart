import 'package:json_annotation/json_annotation.dart';

part 'model_request_pin_reply.g.dart';

@JsonSerializable()
class ModelRequestPinReply {
  String pinId;
  String? targetReplyId;
  String reply;
  ModelRequestPinReply({
    required this.pinId,
    this.targetReplyId,
    required this.reply,
  });

  factory ModelRequestPinReply.fromJson(Map<String, dynamic> json) => _$ModelRequestPinReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestPinReplyToJson(this);
}
