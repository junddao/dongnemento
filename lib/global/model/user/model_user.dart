import 'dart:convert';

class ModelUser {
  String? id;
  String? email;
  String? name;
  String? introduce;
  String? profileImage;
  String? password;

  String? social;
  bool? pushEnabled;
  double? lat;
  double? lng;
  String? address;
  String? createdAt;
  String? updatedAt;
  //  String smsEnabled
  //  String agreeTerms
  //  String phoneNumber

  ModelUser({
    this.id,
    this.email,
    this.name,
    this.introduce,
    this.profileImage,
    this.password,
    this.social,
    this.pushEnabled,
    this.lat,
    this.lng,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'introduce': introduce,
      'profileImage': profileImage,
      'password': password,
      'social': social,
      'pushEnabled': pushEnabled,
      'lat': lat,
      'lng': lng,
      'address': address,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ModelUser.fromMap(Map<String, dynamic> map) {
    return ModelUser(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      introduce: map['introduce'],
      profileImage: map['profileImage'],
      password: map['password'],
      social: map['social'],
      pushEnabled: map['pushEnabled'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      address: map['address'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelUser.fromJson(String source) =>
      ModelUser.fromMap(json.decode(source));

  ModelUser copyWith({
    String? id,
    String? email,
    String? name,
    String? introduce,
    String? profileImage,
    String? password,
    String? social,
    bool? pushEnabled,
    double? lat,
    double? lng,
    String? address,
    String? createdAt,
    String? updatedAt,
  }) {
    return ModelUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      introduce: introduce ?? this.introduce,
      profileImage: profileImage ?? this.profileImage,
      password: password ?? this.password,
      social: social ?? this.social,
      pushEnabled: pushEnabled ?? this.pushEnabled,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
