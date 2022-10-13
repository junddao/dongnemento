import 'dart:convert';

class MeResult {
  Me me;
  MeResult({
    required this.me,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'me': me.toMap(),
    };
  }

  factory MeResult.fromMap(Map<String, dynamic> map) {
    return MeResult(
      me: Me.fromMap(map['me']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MeResult.fromJson(String source) => MeResult.fromMap(json.decode(source));
}

class Me {
  String id;
  String email;
  String username;
  String phone;
  String? birthdate;
  String? gender;
  String updatedAt;
  String createdAt;
  bool? receivesAdMail;
  Me({
    required this.id,
    required this.email,
    required this.username,
    required this.phone,
    this.birthdate,
    this.gender,
    required this.updatedAt,
    required this.createdAt,
    this.receivesAdMail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'birthdate': birthdate,
      'gender': gender,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'receivesAdMail': receivesAdMail,
    };
  }

  factory Me.fromMap(Map<String, dynamic> map) {
    return Me(
      id: map['_id'],
      email: map['email'],
      username: map['username'],
      phone: map['phone'],
      birthdate: map['birthdate'],
      gender: map['gender'],
      updatedAt: map['updatedAt'],
      createdAt: map['createdAt'],
      receivesAdMail: map['receivesAdMail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Me.fromJson(String source) => Me.fromMap(json.decode(source));
}
