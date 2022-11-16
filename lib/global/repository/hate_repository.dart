import 'package:base_project/env.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/common/model_response_common.dart';
import 'package:base_project/global/model/hate/model_request_set_pin_hate.dart';
import 'package:base_project/global/repository/api_service.dart';

class HateRepository {
  static final HateRepository instance = HateRepository._();

  factory HateRepository() {
    return instance;
  }

  HateRepository._();

  String apiUrl = Env.apiHateUrl;

  Future<ApiResponse<bool>> setPinHate(ModelRequestSetPinHate modelRequestSetPinHate) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      Map<String, dynamic> response = await ApiService().post('$apiUrl/pin', modelRequestSetPinHate.toMap());
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
