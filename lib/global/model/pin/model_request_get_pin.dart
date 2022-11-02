import 'dart:convert';

class ModelRequestGetPin {
  double? lat;
  double? lng;
  int? range;
  ModelRequestGetPin({
    this.lat,
    this.lng,
    this.range = 2000,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'range': range,
    };
  }

  factory ModelRequestGetPin.fromMap(Map<String, dynamic> map) {
    return ModelRequestGetPin(
      lat: map['lat'],
      lng: map['lng'],
      range: map['range'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestGetPin.fromJson(String source) => ModelRequestGetPin.fromMap(json.decode(source));
}
