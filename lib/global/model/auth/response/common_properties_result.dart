import 'dart:convert';

import 'package:base_project/global/model/auth/field/properties.dart';

class CommonPropertiesResult {
  Properties? properties;
  CommonPropertiesResult({
    this.properties,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'properties': properties?.toMap(),
    };
  }

  factory CommonPropertiesResult.fromMap(Map<String, dynamic> map) {
    return CommonPropertiesResult(
      properties: map['properties'] != null ? Properties.fromMap(map['properties']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommonPropertiesResult.fromJson(String source) => CommonPropertiesResult.fromMap(json.decode(source));
}
