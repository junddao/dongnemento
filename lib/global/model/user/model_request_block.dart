import 'dart:convert';

class ModelRequestBlock {
  String userId;
  bool isBlocked;
  ModelRequestBlock({
    required this.userId,
    required this.isBlocked,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'isBlocked': isBlocked,
    };
  }

  factory ModelRequestBlock.fromMap(Map<String, dynamic> map) {
    return ModelRequestBlock(
      userId: map['userId'],
      isBlocked: map['isBlocked'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestBlock.fromJson(String source) => ModelRequestBlock.fromMap(json.decode(source));

  ModelRequestBlock copyWith({
    String? userId,
    bool? isBlocked,
  }) {
    return ModelRequestBlock(
      userId: userId ?? this.userId,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }
}
