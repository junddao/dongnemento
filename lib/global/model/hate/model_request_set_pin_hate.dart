import 'dart:convert';

class ModelRequestSetPinHate {
  String pinId;
  ModelRequestSetPinHate({
    required this.pinId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pinId': pinId,
    };
  }

  factory ModelRequestSetPinHate.fromMap(Map<String, dynamic> map) {
    return ModelRequestSetPinHate(
      pinId: map['pinId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestSetPinHate.fromJson(String source) => ModelRequestSetPinHate.fromMap(json.decode(source));

  ModelRequestSetPinHate copyWith({
    String? pinId,
  }) {
    return ModelRequestSetPinHate(
      pinId: pinId ?? this.pinId,
    );
  }
}
