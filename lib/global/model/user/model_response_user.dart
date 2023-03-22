import 'dart:convert';

import 'package:base_project/global/model/user/model_user.dart';

class ModelResponseUser {
  bool success;
  String? error;
  List<ModelUser>? data;
  ModelResponseUser({
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

  factory ModelResponseUser.fromMap(Map<String, dynamic> map) {
    return ModelResponseUser(
      success: map['success'],
      error: map['error'],
      data: map['data'] != null ? List<ModelUser>.from(map['data'].map((x) => ModelUser.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseUser.fromJson(String source) => ModelResponseUser.fromMap(json.decode(source));
}
