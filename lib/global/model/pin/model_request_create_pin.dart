import 'package:json_annotation/json_annotation.dart';

part 'model_request_create_pin.g.dart';

@JsonSerializable()
class ModelRequestCreatePin {
  double lat;
  double lng;
  String title;
  String? body;
  List<String>? images;
  ModelRequestCreatePin({
    required this.lat,
    required this.lng,
    required this.title,
    this.body,
    this.images,
  });

  factory ModelRequestCreatePin.fromMap(Map<String, dynamic> map) {
    return ModelRequestCreatePin(
      lat: map['lat'],
      lng: map['lng'],
      title: map['title'],
      body: map['body'],
      images: List<String>.from(map['images']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'title': title,
      'body': body,
      'images': images,
    };
  }
}
