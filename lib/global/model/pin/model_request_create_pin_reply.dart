import 'package:json_annotation/json_annotation.dart';

part 'model_request_create_pin_reply.g.dart';

@JsonSerializable()
class ModelRequestCreatePinReply {
  String? pinId;
  String? reply;
  String? targetReplyId;

  ModelRequestCreatePinReply({
    this.pinId,
    this.reply,
    this.targetReplyId,
  });

  factory ModelRequestCreatePinReply.fromJson(Map<String, dynamic> json) => _$ModelRequestCreatePinReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestCreatePinReplyToJson(this);
}
