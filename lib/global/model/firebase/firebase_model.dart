import 'package:json_annotation/json_annotation.dart';

part 'firebase_model.g.dart';

@JsonSerializable()
class FirebaseModel {
  String? title;
  String? body;
  String? imageUrl;
  String? authorId;
  String? targetId;

  FirebaseModel({
    this.title,
    this.body,
    this.imageUrl,
    this.authorId,
    this.targetId,
  });

  factory FirebaseModel.fromJson(Map<String, dynamic> json) => _$FirebaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseModelToJson(this);
}
