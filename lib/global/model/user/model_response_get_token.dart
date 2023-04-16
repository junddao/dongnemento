import 'package:json_annotation/json_annotation.dart';

part 'model_response_get_token.g.dart';

@JsonSerializable()
class ModelGetToken {
  String accessToken;
  ModelGetToken({
    required this.accessToken,
  });

  factory ModelGetToken.fromJson(Map<String, dynamic> json) => _$ModelGetTokenFromJson(json);
  Map<String, dynamic> toJson() => _$ModelGetTokenToJson(this);
}
