import 'package:base_project/env.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/common/model_response_common.dart';
import 'package:base_project/global/model/pin/model_request_create_pin.dart';
import 'package:base_project/global/model/pin/model_request_get_pin.dart';
import 'package:base_project/global/model/pin/model_response_get_pin.dart';
import 'package:base_project/global/repository/api_service.dart';

class PinRepository {
  static final PinRepository instance = PinRepository._();

  factory PinRepository() {
    return instance;
  }

  PinRepository._();

  String apiUrl = Env.apiPinUrl;

  Future<ApiResponse<bool>> createPin(ModelRequestCreatePin requestCreatePin) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      Map<String, dynamic> response = await ApiService().post('$apiUrl/create', requestCreatePin.toMap());
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

  Future<ApiResponse<ModelResponseGetPin>> getPins(ModelRequestGetPin requestGetPin) async {
    late ModelResponseGetPin modelResponseGetPin;
    try {
      Map<String, dynamic> response =
          await ApiService().get('$apiUrl/get/pins/${requestGetPin.lat}/${requestGetPin.lng}/${requestGetPin.range}');
      modelResponseGetPin = ModelResponseGetPin.fromMap(response);
      if (modelResponseGetPin.success == true) {
        return ApiResponse.completed(modelResponseGetPin);
      } else {
        return ApiResponse.error(modelResponseGetPin.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<ModelResponseGetPin>> getPin(String id) async {
    late ModelResponseGetPin modelResponseGetPin;
    try {
      Map<String, dynamic> response = await ApiService().get('$apiUrl/get/$id');
      modelResponseGetPin = ModelResponseGetPin.fromMap(response);
      if (modelResponseGetPin.success == true) {
        return ApiResponse.completed(modelResponseGetPin);
      } else {
        return ApiResponse.error(modelResponseGetPin.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<bool>> deletePin(String id) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      Map<String, dynamic> response = await ApiService().delete('$apiUrl/delete/$id');
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
