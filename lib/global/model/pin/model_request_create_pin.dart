import 'package:json_annotation/json_annotation.dart';

import '../../enum/category_type.dart';

part 'model_request_create_pin.g.dart';

@JsonSerializable()
class ModelRequestCreatePin {
  double lat;
  double lng;
  String title;
  String? body;
  CategoryType category;
  int categoryScore;
  DateTime startDate;
  DateTime endDate;
  List<String>? images;
  ModelRequestCreatePin({
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

  factory ModelRequestCreatePin.fromJson(Map<String, dynamic> json) => _$ModelRequestCreatePinFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestCreatePinToJson(this);
}
