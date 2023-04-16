import 'package:json_annotation/json_annotation.dart';

part 'model_request_get_token.g.dart';

@JsonSerializable()
class ModelRequestGetToken {
  String email;
  ModelRequestGetToken({
    required this.email,
  });

  factory ModelRequestGetToken.fromJson(Map<String, dynamic> json) => _$ModelRequestGetTokenFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestGetTokenToJson(this);
}
