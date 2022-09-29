import 'dart:convert';

import 'package:base_project/global/enum/device_type.dart';

class DeviceInput {
  //enum
  DeviceType? deviceType;
  String? deviceToken;
  String? deviceId;
  String? appVersion;
  DeviceInput({
    required this.deviceType,
    this.deviceToken,
    this.deviceId,
    this.appVersion,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceType': deviceType?.name,
      'deviceToken': deviceToken,
      'deviceId': deviceId,
      'appVersion': appVersion,
    };
  }

  factory DeviceInput.fromMap(Map<String, dynamic> map) {
    return DeviceInput(
      deviceType: map['deviceType'] != null ? DeviceType.values.byName(map['deviceType']) : null,
      deviceToken: map['deviceToken'],
      deviceId: map['deviceId'],
      appVersion: map['appVersion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInput.fromJson(String source) => DeviceInput.fromMap(json.decode(source));
}
