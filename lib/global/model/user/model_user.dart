import 'package:json_annotation/json_annotation.dart';

part 'model_user.g.dart';

@JsonSerializable()
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
  String? firebaseToken;
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
    this.firebaseToken,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => _$ModelUserFromJson(json);
  Map<String, dynamic> toJson() => _$ModelUserToJson(this);

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
    String? firebaseToken,
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
      firebaseToken: firebaseToken ?? this.firebaseToken,
    );
  }
}
