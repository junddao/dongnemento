import 'package:json_annotation/json_annotation.dart';

part 'model_request_set_pin_like.g.dart';

@JsonSerializable()
class ModelRequestSetPinLike {
  String pinId;
  ModelRequestSetPinLike({
    required this.pinId,
  });

  factory ModelRequestSetPinLike.fromJson(Map<String, dynamic> json) => _$ModelRequestSetPinLikeFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestSetPinLikeToJson(this);
}
