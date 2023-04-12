import 'package:json_annotation/json_annotation.dart';

part 'data_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class DataResponse<T> {
  final T? data;
  bool success;
  String? error;

  DataResponse(this.data, this.success, this.error);

  // Interesting bits here → ----------------------------------- ↓ ↓
  factory DataResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$DataResponseFromJson<T>(json, fromJsonT);

  // And here → ------------- ↓ ↓
  Map<String, dynamic> toJson(Object Function(T) toJsonT) => _$DataResponseToJson<T>(this, toJsonT);
}
