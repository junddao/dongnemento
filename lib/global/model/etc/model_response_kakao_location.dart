import 'dart:convert';

class ModelResponseKakaoLocation {
  List<ModelResponseKakaoLocationAddress> documents;
  ModelResponseKakaoLocation({
    required this.documents,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documents': documents.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelResponseKakaoLocation.fromMap(Map<String, dynamic> map) {
    return ModelResponseKakaoLocation(
      documents: List<ModelResponseKakaoLocationAddress>.from(map['documents']
          .map((x) => ModelResponseKakaoLocationAddress.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseKakaoLocation.fromJson(String source) =>
      ModelResponseKakaoLocation.fromMap(json.decode(source));
}

class ModelResponseKakaoLocationAddress {
  String region_type;
  String code;
  String address_name;
  String region_1depth_name;
  String region_2depth_name;
  String region_3depth_name;
  String region_4depth_name;
  double x;
  double y;
  ModelResponseKakaoLocationAddress({
    required this.region_type,
    required this.code,
    required this.address_name,
    required this.region_1depth_name,
    required this.region_2depth_name,
    required this.region_3depth_name,
    required this.region_4depth_name,
    required this.x,
    required this.y,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'region_type': region_type,
      'code': code,
      'address_name': address_name,
      'region_1depth_name': region_1depth_name,
      'region_2depth_name': region_2depth_name,
      'region_3depth_name': region_3depth_name,
      'region_4depth_name': region_4depth_name,
      'x': x,
      'y': y,
    };
  }

  factory ModelResponseKakaoLocationAddress.fromMap(Map<String, dynamic> map) {
    return ModelResponseKakaoLocationAddress(
      region_type: map['region_type'],
      code: map['code'],
      address_name: map['address_name'],
      region_1depth_name: map['region_1depth_name'],
      region_2depth_name: map['region_2depth_name'],
      region_3depth_name: map['region_3depth_name'],
      region_4depth_name: map['region_4depth_name'],
      x: map['x']?.toDouble(),
      y: map['y']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponseKakaoLocationAddress.fromJson(String source) =>
      ModelResponseKakaoLocationAddress.fromMap(json.decode(source));
}
