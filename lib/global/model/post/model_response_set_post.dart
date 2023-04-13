import 'package:json_annotation/json_annotation.dart';

part 'model_response_set_post.g.dart';

@JsonSerializable()
class ModelLocation {
  String? address;
  double? lat;
  double? lng;
  ModelLocation({
    this.address,
    this.lat,
    this.lng,
  });

  factory ModelLocation.fromJson(Map<String, dynamic> json) => _$ModelLocationFromJson(json);
  Map<String, dynamic> toJson() => _$ModelLocationToJson(this);

  ModelLocation copyWith({
    String? address,
    double? lat,
    double? lng,
  }) {
    return ModelLocation(
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
