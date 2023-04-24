import 'package:json_annotation/json_annotation.dart';

import '../../enum/category_type.dart';

part 'model_response_pins.g.dart';

@JsonSerializable()
class ModelResponsePins {
  String id;
  double lat;
  double lng;
  String userId;
  String userName;
  CategoryType category;
  int categoryScore;
  bool isUserBlocked;
  int? likeCount;
  bool? isLiked;
  int replyCount;
  String? title;
  List<String>? images;
  String? body;
  String? createdAt;
  String? updatedAt;
  ModelResponsePins({
    required this.id,
    required this.lat,
    required this.lng,
    required this.userId,
    required this.userName,
    required this.category,
    required this.categoryScore,
    required this.isUserBlocked,
    this.likeCount,
    this.isLiked,
    required this.replyCount,
    this.title,
    this.images,
    this.body,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelResponsePins.fromJson(Map<String, dynamic> json) => _$ModelResponsePinsFromJson(json);

  Map<String, dynamic> toJson() => _$ModelResponsePinsToJson(this);
}
