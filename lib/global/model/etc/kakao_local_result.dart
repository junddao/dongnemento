import 'dart:convert';

class KakaoLocalResponseData {
  List<KakaoLocalResult> documents;
  KakaoLocalResponseData({
    required this.documents,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'documents': documents.map((x) => x.toMap()).toList(),
    };
  }

  factory KakaoLocalResponseData.fromMap(Map<String, dynamic> map) {
    return KakaoLocalResponseData(
      documents: List<KakaoLocalResult>.from(
          map['documents'].map((x) => KakaoLocalResult.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory KakaoLocalResponseData.fromJson(String source) =>
      KakaoLocalResponseData.fromMap(json.decode(source));
}

class KakaoLocalResult {
  String address_name;
  String category_group_code;
  String category_group_name;
  String category_name;
  String distance;
  String id;
  String phone;
  String place_name;
  String place_url;
  String road_address_name;
  String x;
  String y;
  KakaoLocalResult({
    required this.address_name,
    required this.category_group_code,
    required this.category_group_name,
    required this.category_name,
    required this.distance,
    required this.id,
    required this.phone,
    required this.place_name,
    required this.place_url,
    required this.road_address_name,
    required this.x,
    required this.y,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_name': address_name,
      'category_group_code': category_group_code,
      'category_group_name': category_group_name,
      'category_name': category_name,
      'distance': distance,
      'id': id,
      'phone': phone,
      'place_name': place_name,
      'place_url': place_url,
      'road_address_name': road_address_name,
      'x': x,
      'y': y,
    };
  }

  factory KakaoLocalResult.fromMap(Map<String, dynamic> map) {
    return KakaoLocalResult(
      address_name: map['address_name'],
      category_group_code: map['category_group_code'],
      category_group_name: map['category_group_name'],
      category_name: map['category_name'],
      distance: map['distance'],
      id: map['id'],
      phone: map['phone'],
      place_name: map['place_name'],
      place_url: map['place_url'],
      road_address_name: map['road_address_name'],
      x: map['x'],
      y: map['y'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KakaoLocalResult.fromJson(String source) =>
      KakaoLocalResult.fromMap(json.decode(source));
}
