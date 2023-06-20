import 'package:json_annotation/json_annotation.dart';

import '../../enum/category_type.dart';

part 'model_request_update_pin.g.dart';

@JsonSerializable()
class ModelRequestUpdatePin {
  double lat;
  double lng;
  String title;
  String? body;
  CategoryType category;
  int categoryScore;
  DateTime startDate;
  DateTime endDate;
  List<String>? images;
  ModelRequestUpdatePin({
    required this.lat,
    required this.lng,
    required this.title,
    this.body,
    required this.category,
    required this.categoryScore,
    required this.startDate,
    required this.endDate,
    this.images,
  });

  factory ModelRequestUpdatePin.fromJson(Map<String, dynamic> json) => _$ModelRequestUpdatePinFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestUpdatePinToJson(this);
}
