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
      data: map['data'] != null
          ? List<ResponsePin>.from(
              map['data'].map((x) => ResponsePin.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseGetPin.fromJson(String source) =>
      ModelResponseGetPin.fromMap(json.decode(source));

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

// class ResponseGetPinData {
//   ResponsePin? pin;
//   int? userId;
//   String? name;
//   String? profileImage;
//   bool? liked;
//   bool? hated;
//   String? createAt;
//   ResponseGetPinData({
//     this.pin,
//     this.userId,
//     this.name,
//     this.profileImage,
//     this.liked = false,
//     this.hated,
//     this.createAt,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'pin': pin?.toMap(),
//       'userId': userId,
//       'name': name,
//       'profileImage': profileImage,
//       'liked': liked,
//       'hated': hated,
//       'createAt': createAt,
//     };
//   }

//   factory ResponseGetPinData.fromMap(Map<String, dynamic> map) {
//     return ResponseGetPinData(
//       pin: map['pin'] != null ? ResponsePin.fromMap(map['pin']) : null,
//       userId: map['userId'],
//       name: map['name'],
//       profileImage: map['profileImage'],
//       liked: map['liked'],
//       hated: map['hated'],
//       createAt: map['createAt'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ResponseGetPinData.fromJson(String source) =>
//       ResponseGetPinData.fromMap(json.decode(source));
// }

class ResponsePin {
  String? id;
  double? lat;
  double? lng;
  String? title;
  String? body;
  // List<String>? images;
  String? userId;

  ResponsePin({
    this.id,
    this.lat,
    this.lng,
    this.title,
    this.body,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'lat': lat,
      'lng': lng,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }

  factory ResponsePin.fromMap(Map<String, dynamic> map) {
    return ResponsePin(
      id: map['_id'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      title: map['title'],
      body: map['body'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponsePin.fromJson(String source) =>
      ResponsePin.fromMap(json.decode(source));

  ResponsePin copyWith({
    String? id,
    double? lat,
    double? lng,
    String? title,
    String? body,
    String? userId,
  }) {
    return ResponsePin(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }
}
