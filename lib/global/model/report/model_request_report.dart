import 'package:json_annotation/json_annotation.dart';

part 'model_request_report.g.dart';

@JsonSerializable()
class ModelRequestReport {
  String pinId;
  ModelRequestReport({
    required this.pinId,
  });
  factory ModelRequestReport.fromJson(Map<String, dynamic> json) => _$ModelRequestReportFromJson(json);
  Map<String, dynamic> toJson() => _$ModelRequestReportToJson(this);
}
