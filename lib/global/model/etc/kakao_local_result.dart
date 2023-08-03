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
      documents: List<KakaoLocalResult>.from(map['documents'].map((x) => KakaoLocalResult.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory KakaoLocalResponseData.fromJson(String source) => KakaoLocalResponseData.fromMap(json.decode(source));
}

class KakaoLocalResult {
  String address_name;
  String x;
  String y;
  KakaoLocalResult({
    required this.address_name,
    required this.x,
    required this.y,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_name': address_name,
      'x': x,
      'y': y,
    };
  }

  factory KakaoLocalResult.fromMap(Map<String, dynamic> map) {
    return KakaoLocalResult(
      address_name: map['address_name'],
      x: map['x'],
      y: map['y'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KakaoLocalResult.fromJson(String source) => KakaoLocalResult.fromMap(json.decode(source));
}
