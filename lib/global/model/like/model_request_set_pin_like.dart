import 'dart:convert';

class ModelRequestSetPinLike {
  String pinId;
  ModelRequestSetPinLike({
    required this.pinId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pinId': pinId,
    };
  }

  factory ModelRequestSetPinLike.fromMap(Map<String, dynamic> map) {
    return ModelRequestSetPinLike(
      pinId: map['pinId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestSetPinLike.fromJson(String source) => ModelRequestSetPinLike.fromMap(json.decode(source));

  ModelRequestSetPinLike copyWith({
    String? pinId,
  }) {
    return ModelRequestSetPinLike(
      pinId: pinId ?? this.pinId,
    );
  }
}
