import 'package:base_project/env.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/common/model_response_common.dart';
import 'package:base_project/global/model/like/model_request_set_pin_like.dart';
import 'package:base_project/global/repository/api_service.dart';

class LikeRepository {
  static final LikeRepository instance = LikeRepository._();

  factory LikeRepository() {
    return instance;
  }

  LikeRepository._();

  String apiUrl = Env.apiLikeUrl;

  Future<ApiResponse<bool>> setPinLike(ModelRequestSetPinLike modelRequestSetPinLike) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      Map<String, dynamic> response = await ApiService().post('$apiUrl/pin', modelRequestSetPinLike.toMap());
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
