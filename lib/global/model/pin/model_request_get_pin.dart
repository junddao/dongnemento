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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelRequestGetPin && other.lat == lat && other.lng == lng && other.range == range;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode ^ range.hashCode;
}
