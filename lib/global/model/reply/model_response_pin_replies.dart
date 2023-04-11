import 'dart:convert';

class ModelResponseGetPinReplies {
  bool success;
  String? error;
  List<PinReplies>? data;
  ModelResponseGetPinReplies({
    required this.success,
    this.error,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'error': error,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelResponseGetPinReplies.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetPinReplies(
      success: map['success'],
      error: map['error'],
      data: map['data'] != null ? List<PinReplies>.from(map['data'].map((x) => PinReplies.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetPinReplies.fromJson(String source) => ModelResponseGetPinReplies.fromMap(json.decode(source));

  ModelResponseGetPinReplies copyWith({
    bool? success,
    String? error,
    List<PinReplies>? data,
  }) {
    return ModelResponseGetPinReplies(
      success: success ?? this.success,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PinReplies {
  String id;
  String pinId;
  String userId;
  String userName;
  String? targetReplyId;
  String reply;
  int likeCount;
  bool? isLiked;
  int hateCount;
  bool? isHated;
  String createdAt;
  String updatedAt;
  PinReplies({
    required this.id,
    required this.pinId,
    required this.userId,
    required this.userName,
    required this.targetReplyId,
    required this.reply,
    required this.likeCount,
    this.isLiked,
    required this.hateCount,
    this.isHated,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pinId': pinId,
      'userId': userId,
      'userName': userName,
      'targetReplyId': targetReplyId,
      'reply': reply,
      'likeCount': likeCount,
      'isLiked': isLiked,
      'hateCount': hateCount,
      'isHated': isHated,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PinReplies.fromMap(Map<String, dynamic> map) {
    return PinReplies(
      id: map['id'],
      pinId: map['pinId'],
      userId: map['userId'],
      userName: map['userName'],
      targetReplyId: map['targetReplyId'],
      reply: map['reply'],
      likeCount: map['likeCount']?.toInt(),
      isLiked: map['isLiked'],
      hateCount: map['hateCount']?.toInt(),
      isHated: map['isHated'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PinReplies.fromJson(String source) => PinReplies.fromMap(json.decode(source));

  PinReplies copyWith({
    String? id,
    String? pinId,
    String? userId,
    String? userName,
    String? targetReplyId,
    String? reply,
    int? likeCount,
    bool? isLiked,
    int? hateCount,
    bool? isHated,
    String? createdAt,
    String? updatedAt,
  }) {
    return PinReplies(
      id: id ?? this.id,
      pinId: pinId ?? this.pinId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      targetReplyId: targetReplyId ?? this.targetReplyId,
      reply: reply ?? this.reply,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      hateCount: hateCount ?? this.hateCount,
      isHated: isHated ?? this.isHated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
