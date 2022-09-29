// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

class FirebaseMsgDataEntity {
  int? badge;
  String? linkSid;
  String? body;
  String? title;
  String? clickAction;
  String? roomId;
  String? roomType;

  FirebaseMsgDataEntity({
    this.badge,
    this.linkSid,
    this.body,
    this.title,
    this.clickAction,
    this.roomId,
    this.roomType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'badge': badge,
      'linkSid': linkSid,
      'body': body,
      'title': title,
      'clickAction': clickAction,
      'roomId': roomId,
      'roomType': roomType,
    };
  }

  factory FirebaseMsgDataEntity.fromMap(Map<String, dynamic> map) {
    return FirebaseMsgDataEntity(
      badge: map['badge'] != null ? map['badge']?.toInt() : null,
      linkSid: map['linkSid'],
      body: map['body'],
      title: map['title'],
      clickAction: map['clickAction'],
      roomId: map['roomId'],
      roomType: map['roomType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseMsgDataEntity.fromJson(String source) => FirebaseMsgDataEntity.fromMap(json.decode(source));
}
