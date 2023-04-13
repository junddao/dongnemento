import 'package:json_annotation/json_annotation.dart';

part 'model_request_get_pin.g.dart';

@JsonSerializable()
class ModelRequestGetPin {
  double? lat;
  double? lng;
  int? range;
  ModelRequestGetPin({
    this.lat,
    this.lng,
    this.range = 2000,
  });

  factory ModelRequestGetPin.fromJson(Map<String, dynamic> json) => _$ModelRequestGetPinFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestGetPinToJson(this);
}
