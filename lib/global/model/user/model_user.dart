import 'dart:convert';

class ModelUser {
  String? id;
  String? email;
  String? name;
  String? introduce;
  String? profileImage;
  String? password;
  bool? isBlocked;

  String? social;
  bool? pushEnabled;
  double? lat;
  double? lng;
  String? address;
  List<String>? blockedUserIds;
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
    this.isBlocked,
    this.social,
    this.pushEnabled,
    this.lat,
    this.lng,
    this.address,
    this.blockedUserIds,
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
      'isBlocked': isBlocked,
      'social': social,
      'pushEnabled': pushEnabled,
      'lat': lat,
      'lng': lng,
      'address': address,
      'blockedUserIds': blockedUserIds,
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
      isBlocked: map['isBlocked'],
      social: map['social'],
      pushEnabled: map['pushEnabled'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      address: map['address'],
      blockedUserIds: map['blockedUserIds'] != null ? List<String>.from(map['blockedUserIds']) : null,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelUser.fromJson(String source) => ModelUser.fromMap(json.decode(source));

  ModelUser copyWith({
    String? id,
    String? email,
    String? name,
    String? introduce,
    String? profileImage,
    String? password,
    bool? isBlocked,
    String? social,
    bool? pushEnabled,
    double? lat,
    double? lng,
    String? address,
    List<String>? blockedUserIds,
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
      isBlocked: isBlocked ?? this.isBlocked,
      social: social ?? this.social,
      pushEnabled: pushEnabled ?? this.pushEnabled,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
      blockedUserIds: blockedUserIds ?? this.blockedUserIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
