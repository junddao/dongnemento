import 'dart:convert';

class ModelResponseSetPost {
  String? address;
  double? lat;
  double? lng;
  ModelResponseSetPost({
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

  factory ModelResponseSetPost.fromMap(Map<String, dynamic> map) {
    return ModelResponseSetPost(
      address: map['address'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseSetPost.fromJson(String source) =>
      ModelResponseSetPost.fromMap(json.decode(source));

  ModelResponseSetPost copyWith({
    String? address,
    double? lat,
    double? lng,
  }) {
    return ModelResponseSetPost(
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
