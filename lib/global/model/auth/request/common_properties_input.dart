import 'dart:convert';

class CommonPropertiesInput {
  List<String>? keys;
  CommonPropertiesInput({
    this.keys,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keys': keys,
    };
  }

  factory CommonPropertiesInput.fromMap(Map<String, dynamic> map) {
    return CommonPropertiesInput(
      keys: map['keys'] != null ? List<String>.from(map['keys']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommonPropertiesInput.fromJson(String source) => CommonPropertiesInput.fromMap(json.decode(source));
}
