import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_request_get_pin.g.dart';

@JsonSerializable()
class ModelRequestGetPin extends Equatable {
  final double? lat;
  final double? lng;
  final int? range;
  const ModelRequestGetPin({
    this.lat,
    this.lng,
    this.range = 2000,
  });

  factory ModelRequestGetPin.fromJson(Map<String, dynamic> json) => _$ModelRequestGetPinFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestGetPinToJson(this);

  @override
  List<Object?> get props => [
        lat,
        lng,
        range,
      ];
}
