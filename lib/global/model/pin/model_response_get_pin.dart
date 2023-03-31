import 'dart:convert';

class ModelResponseGetPin {
  bool success;
  String? error;
  List<ResponsePin>? data;
  ModelResponseGetPin({
    required this.success,
    this.error,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'error': error,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelResponseGetPin.fromMap(Map<String, dynamic> map) {
    return ModelResponseGetPin(
      success: map['success'],
      error: map['error'],
      data: map['data'] != null ? List<ResponsePin>.from(map['data'].map((x) => ResponsePin.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetPin.fromJson(String source) => ModelResponseGetPin.fromMap(json.decode(source));

  ModelResponseGetPin copyWith({
    bool? success,
    String? error,
    List<ResponsePin>? data,
  }) {
    return ModelResponseGetPin(
      success: success ?? this.success,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ResponsePin {
  String id;
  double? lat;
  double? lng;
  String? title;
  String? body;
  List<String>? images;
  String userId;
  String? userName;
  String? userProfileImage;
  int? likeCount;
  bool? isLiked;
  int? hateCount;
  bool? isHated;
  String? createdAt;
  String? updatedAt;
  ResponsePin({
    required this.id,
    this.lat,
    this.lng,
    this.title,
    this.body,
    this.images,
    required this.userId,
    this.userName,
    this.userProfileImage,
    this.likeCount,
    this.isLiked,
    this.hateCount,
    this.isHated,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'lat': lat,
      'lng': lng,
      'title': title,
      'body': body,
      'images': images,
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'likeCount': likeCount,
      'isLiked': isLiked,
      'hateCount': hateCount,
      'isHated': isHated,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ResponsePin.fromMap(Map<String, dynamic> map) {
    return ResponsePin(
      id: map['_id'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      title: map['title'],
      body: map['body'],
      images: map['images'] != null ? List<String>.from(map['images']) : null,
      userId: map['userId'],
      userName: map['userName'],
      userProfileImage: map['userProfileImage'],
      likeCount: map['likeCount']?.toInt(),
      isLiked: map['isLiked'],
      hateCount: map['hateCount']?.toInt(),
      isHated: map['isHated'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsePin.fromJson(String source) => ResponsePin.fromMap(json.decode(source));

  ResponsePin copyWith({
    String? id,
    double? lat,
    double? lng,
    String? title,
    String? body,
    List<String>? images,
    String? userId,
    String? userName,
    String? userProfileImage,
    int? likeCount,
    bool? isLiked,
    int? hateCount,
    bool? isHated,
    String? createdAt,
    String? updatedAt,
  }) {
    return ResponsePin(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      title: title ?? this.title,
      body: body ?? this.body,
      images: images ?? this.images,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      hateCount: hateCount ?? this.hateCount,
      isHated: isHated ?? this.isHated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
