import 'package:base_project/env.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/common/model_response_common.dart';
import 'package:base_project/global/model/report/model_request_report.dart';
import 'package:base_project/global/repository/api_service.dart';

class ReportRepository {
  static final ReportRepository instance = ReportRepository._();

  factory ReportRepository() {
    return instance;
  }

  ReportRepository._();

  String apiUrl = Env.apiReportUrl;

  Future<ApiResponse<bool>> createReport(ModelRequestReport modelRequestReport) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      Map<String, dynamic> response = await ApiService().post('$apiUrl/create', modelRequestReport.toMap());
      modelResponseCommon = ModelResponseCommon.fromMap(response);
      if (modelResponseCommon.success == true) {
        return ApiResponse.completed(true);
      } else {
        return ApiResponse.error(modelResponseCommon.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
