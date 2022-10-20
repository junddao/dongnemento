import 'dart:convert';

class KakaoLocalResult {
  String? id;
  String? placeName;
  int? distance;
  String? placeUrl;
  String? categoryName;
  String? addressName;
  String? roadAddressName;
  String? phone;
  String? categoryGroupCode;
  String? categoryGroupName;
  double? longitude;
  double? latitude;

  KakaoLocalResult({
    this.id,
    this.placeName,
    this.distance,
    this.placeUrl,
    this.categoryName,
    this.addressName,
    this.roadAddressName,
    this.phone,
    this.categoryGroupCode,
    this.categoryGroupName,
    this.longitude,
    this.latitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'placeName': placeName,
      'distance': distance,
      'placeUrl': placeUrl,
      'categoryName': categoryName,
      'addressName': addressName,
      'roadAddressName': roadAddressName,
      'phone': phone,
      'categoryGroupCode': categoryGroupCode,
      'categoryGroupName': categoryGroupName,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory KakaoLocalResult.fromMap(Map<String, dynamic> map) {
    return KakaoLocalResult(
      id: map['id'],
      placeName: map['placeName'],
      distance: map['distance'],
      placeUrl: map['placeUrl'],
      categoryName: map['categoryName'],
      addressName: map['addressName'],
      roadAddressName: map['roadAddressName'],
      phone: map['phone'],
      categoryGroupCode: map['categoryGroupCode'],
      categoryGroupName: map['categoryGroupName'],
      longitude: map['longitude'],
      latitude: map['latitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KakaoLocalResult.fromJson(String source) =>
      KakaoLocalResult.fromMap(json.decode(source));
}
