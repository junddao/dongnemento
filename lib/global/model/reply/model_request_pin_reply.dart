import 'dart:convert';

class ModelRequestPinReply {
  String pinId;
  String? targetReplyId;
  String reply;
  ModelRequestPinReply({
    required this.pinId,
    this.targetReplyId,
    required this.reply,
  });

  ModelRequestPinReply copyWith({
    String? pinId,
    String? targetReplyId,
    String? reply,
  }) {
    return ModelRequestPinReply(
      pinId: pinId ?? this.pinId,
      targetReplyId: targetReplyId ?? this.targetReplyId,
      reply: reply ?? this.reply,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pinId': pinId,
      'targetReplyId': targetReplyId,
      'reply': reply,
    };
  }

  factory ModelRequestPinReply.fromMap(Map<String, dynamic> map) {
    return ModelRequestPinReply(
      pinId: map['pinId'],
      targetReplyId: map['targetReplyId'],
      reply: map['reply'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestPinReply.fromJson(String source) => ModelRequestPinReply.fromMap(json.decode(source));
}
