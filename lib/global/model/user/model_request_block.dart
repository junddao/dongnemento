import 'package:json_annotation/json_annotation.dart';

part 'model_request_block.g.dart';

@JsonSerializable()
class ModelRequestBlock {
  String userId;
  bool isBlocked;
  ModelRequestBlock({
    required this.userId,
    required this.isBlocked,
  });

  factory ModelRequestBlock.fromJson(Map<String, dynamic> json) => _$ModelRequestBlockFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestBlockToJson(this);
}
