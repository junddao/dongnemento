import 'package:json_annotation/json_annotation.dart';

part 'model_request_set_pin_hate.g.dart';

@JsonSerializable()
class ModelRequestSetPinHate {
  String pinId;
  ModelRequestSetPinHate({
    required this.pinId,
  });

  factory ModelRequestSetPinHate.fromJson(Map<String, dynamic> json) => _$ModelRequestSetPinHateFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestSetPinHateToJson(this);
}
