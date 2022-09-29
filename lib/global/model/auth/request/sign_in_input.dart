import 'dart:convert';

import 'package:base_project/global/model/auth/request/device_input.dart';

class SignInInput {
  String email;
  String password;
  bool? keep;
  DeviceInput? device;
  SignInInput({
    required this.email,
    required this.password,
    this.keep,
    this.device,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});
    if (keep != null) {
      result.addAll({'keep': keep});
    }
    if (device != null) {
      result.addAll({'device': device!.toMap()});
    }

    return result;
  }

  factory SignInInput.fromMap(Map<String, dynamic> map) {
    return SignInInput(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      keep: map['keep'],
      device: map['device'] != null ? DeviceInput.fromMap(map['device']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInInput.fromJson(String source) => SignInInput.fromMap(json.decode(source));
}
