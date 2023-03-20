import 'dart:convert';

class ModelRequestReport {
  String pinId;
  ModelRequestReport({
    required this.pinId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pinId': pinId,
    };
  }

  factory ModelRequestReport.fromMap(Map<String, dynamic> map) {
    return ModelRequestReport(
      pinId: map['pinId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestReport.fromJson(String source) => ModelRequestReport.fromMap(json.decode(source));

  ModelRequestReport copyWith({
    String? pinId,
  }) {
    return ModelRequestReport(
      pinId: pinId ?? this.pinId,
    );
  }
}
