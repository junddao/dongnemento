import 'package:json_annotation/json_annotation.dart';

part 'model_request_update.g.dart';

@JsonSerializable()
class ModelRequestUpdate {
  String? id;
  String? email;
  String? name;
  String? introduce;
  String? profileImage;
  double? lat;
  double? lng;
  String? address;
  String? social;
  bool? pushEnabled;
  ModelRequestUpdate({
    this.id,
    this.email,
    this.name,
    this.introduce,
    this.profileImage,
    this.lat,
    this.lng,
    this.address,
    this.social,
    this.pushEnabled,
  });

  factory ModelRequestUpdate.fromJson(Map<String, dynamic> json) => _$ModelRequestUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestUpdateToJson(this);
}
