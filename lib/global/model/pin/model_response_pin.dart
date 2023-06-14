import 'package:base_project/global/enum/category_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_response_pin.g.dart';

@JsonSerializable()
class ModelResponsePin {
  String id;
  double? lat;
  double? lng;
  String? title;
  bool? isUserBlocked;
  int? replyCount;
  String? body;
  List<String>? images;
  CategoryType category;
  int categoryScore;
  String userId;
  String? userName;
  String? userProfileImage;
  int? likeCount;
  bool? isLiked;
  int? hateCount;
  bool? isHated;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  ModelResponsePin({
    required this.id,
    this.lat,
    this.lng,
    this.title,
    this.isUserBlocked,
    this.replyCount,
    this.body,
    this.images,
    required this.category,
    required this.categoryScore,
    required this.userId,
    this.userName,
    this.userProfileImage,
    this.likeCount,
    this.isLiked,
    this.hateCount,
    this.isHated,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelResponsePin.fromJson(Map<String, dynamic> json) => _$ModelResponsePinFromJson(json);

  Map<String, dynamic> toJson() => _$ModelResponsePinToJson(this);

  ModelResponsePin copyWith({
    String? id,
    double? lat,
    double? lng,
    String? title,
    bool? isUserBlocked,
    int? replyCount,
    String? body,
    List<String>? images,
    CategoryType? category,
    int? categoryScore,
    String? userId,
    String? userName,
    String? userProfileImage,
    int? likeCount,
    bool? isLiked,
    int? hateCount,
    bool? isHated,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ModelResponsePin(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      title: title ?? this.title,
      isUserBlocked: isUserBlocked ?? this.isUserBlocked,
      replyCount: replyCount ?? this.replyCount,
      body: body ?? this.body,
      images: images ?? this.images,
      category: category ?? this.category,
      categoryScore: categoryScore ?? this.categoryScore,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      hateCount: hateCount ?? this.hateCount,
      isHated: isHated ?? this.isHated,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
