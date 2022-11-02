import 'dart:convert';

class ModelFileResponse {
  bool success;
  String? error;
  List<String>? data;
  ModelFileResponse({
    required this.success,
    this.error,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'error': error,
      'data': data,
    };
  }

  factory ModelFileResponse.fromMap(Map<String, dynamic> map) {
    return ModelFileResponse(
      success: map['success'],
      error: map['error'],
      data: List<String>.from(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelFileResponse.fromJson(String source) => ModelFileResponse.fromMap(json.decode(source));

  ModelFileResponse copyWith({
    bool? success,
    String? error,
    List<String>? data,
  }) {
    return ModelFileResponse(
      success: success ?? this.success,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
