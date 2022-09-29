import 'dart:convert';

class CodeResult {
  String code;
  CodeResult({
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
    };
  }

  factory CodeResult.fromMap(Map<String, dynamic> map) {
    return CodeResult(
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeResult.fromJson(String source) => CodeResult.fromMap(json.decode(source));
}
