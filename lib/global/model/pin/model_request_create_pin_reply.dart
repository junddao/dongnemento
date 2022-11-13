import 'dart:convert';

class ModelRequestCreatePinReply {
  String? pinId;
  String? reply;
  String? targetReplyId;

  ModelRequestCreatePinReply({
    this.pinId,
    this.reply,
    this.targetReplyId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pinId': pinId,
      'reply': reply,
      'targetReplyId': targetReplyId,
    };
  }

  factory ModelRequestCreatePinReply.fromMap(Map<String, dynamic> map) {
    return ModelRequestCreatePinReply(
      pinId: map['pinId'],
      reply: map['reply'],
      targetReplyId: map['targetReplyId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestCreatePinReply.fromJson(String source) => ModelRequestCreatePinReply.fromMap(json.decode(source));

  ModelRequestCreatePinReply copyWith({
    String? pinId,
    String? reply,
    String? targetReplyId,
  }) {
    return ModelRequestCreatePinReply(
      pinId: pinId ?? this.pinId,
      reply: reply ?? this.reply,
      targetReplyId: targetReplyId ?? this.targetReplyId,
    );
  }
}
