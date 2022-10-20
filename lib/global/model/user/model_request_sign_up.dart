import 'dart:convert';

class ModelRequestSignUp {
  String uid;
  String social;
  String email;
  String name;
  String password;
  String? profileImage;
  double? lat;
  double? lng;
  String? address;
  ModelRequestSignUp({
    required this.uid,
    required this.social,
    required this.email,
    required this.name,
    required this.password,
    this.profileImage,
    this.lat,
    this.lng,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'social': social,
      'email': email,
      'name': name,
      'password': password,
      'profileImage': profileImage,
      'lat': lat,
      'lng': lng,
      'address': address,
    };
  }

  factory ModelRequestSignUp.fromMap(Map<String, dynamic> map) {
    return ModelRequestSignUp(
      uid: map['uid'],
      social: map['social'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
      profileImage: map['profileImage'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestSignUp.fromJson(String source) =>
      ModelRequestSignUp.fromMap(json.decode(source));
}
