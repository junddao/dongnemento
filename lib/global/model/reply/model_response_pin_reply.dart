import 'package:json_annotation/json_annotation.dart';

part 'model_response_pin_reply.g.dart';

@JsonSerializable()
class ModelResponsePinReply {
  String id;
  String pinId;
  String userId;
  String userName;
  String? targetReplyId;
  String reply;
  int? likeCount;
  bool? isLiked;
  int? hateCount;
  bool? isHated;
  String createdAt;
  String updatedAt;
  ModelResponsePinReply({
    required this.id,
    required this.pinId,
    required this.userId,
    required this.userName,
    this.targetReplyId,
    required this.reply,
    this.likeCount,
    this.isLiked,
    this.hateCount,
    this.isHated,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ModelResponsePinReply.fromJson(Map<String, dynamic> json) => _$ModelResponsePinReplyFromJson(json);

  Map<String, dynamic> toJson() => _$ModelResponsePinReplyToJson(this);
}
