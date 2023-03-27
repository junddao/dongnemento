import 'dart:convert';

class ModelRequestKakaoSignIn {
  String name;
  String email;
  String profileImage;
  ModelRequestKakaoSignIn({
    required this.name,
    required this.email,
    required this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profileImage': profileImage,
    };
  }

  factory ModelRequestKakaoSignIn.fromMap(Map<String, dynamic> map) {
    return ModelRequestKakaoSignIn(
      name: map['name'],
      email: map['email'],
      profileImage: map['profileImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelRequestKakaoSignIn.fromJson(String source) => ModelRequestKakaoSignIn.fromMap(json.decode(source));
}
