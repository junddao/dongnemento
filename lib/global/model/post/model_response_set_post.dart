import 'dart:convert';

class ModelLocation {
  String? address;
  double? lat;
  double? lng;
  ModelLocation({
    this.address,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }

  factory ModelLocation.fromMap(Map<String, dynamic> map) {
    return ModelLocation(
      address: map['address'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelLocation.fromJson(String source) =>
      ModelLocation.fromMap(json.decode(source));

  ModelLocation copyWith({
    String? address,
    double? lat,
    double? lng,
  }) {
    return ModelLocation(
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
