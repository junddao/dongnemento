import 'dart:convert';

class ModelRequestUpdate {
  String? id;
  String? email;
  String? name;
  String? introduce;
  String? profileImage;
  double? lat;
  double? lng;
  String? address;
  String? social;
  bool? pushEnabled;
  ModelRequestUpdate({
    this.id,
    this.email,
    this.name,
    this.introduce,
    this.profileImage,
    this.lat,
    this.lng,
    this.address,
    this.social,
    this.pushEnabled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'introduce': introduce,
      'profileImage': profileImage,
      'lat': lat,
      'lng': lng,
      'address': address,
      'social': social,
      'pushEnabled': pushEnabled,
    };
  }

  factory ModelRequestUpdate.fromMap(Map<String, dynamic> map) {
    return ModelRequestUpdate(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      introduce: map['introduce'],
      profileImage: map['profileImage'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      address: map['address'],
      social: map['social'],
      pushEnabled: map['pushEnabled'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestUpdate.fromJson(String source) =>
      ModelRequestUpdate.fromMap(json.decode(source));

  ModelRequestUpdate copyWith({
    String? id,
    String? email,
    String? name,
    String? introduce,
    String? profileImage,
    double? lat,
    double? lng,
    String? address,
    String? social,
    bool? pushEnabled,
  }) {
    return ModelRequestUpdate(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      introduce: introduce ?? this.introduce,
      profileImage: profileImage ?? this.profileImage,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
      social: social ?? this.social,
      pushEnabled: pushEnabled ?? this.pushEnabled,
    );
  }
}
