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

  factory ModelRequestCreatePin.fromJson(Map<String, dynamic> json) => _$ModelRequestCreatePinFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestCreatePinToJson(this);
}
