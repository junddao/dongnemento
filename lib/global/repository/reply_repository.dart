import 'package:base_project/env.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/common/model_response_common.dart';
import 'package:base_project/global/model/pin/model_request_create_pin_reply.dart';
import 'package:base_project/global/model/reply/model_response_pin_replies.dart';
import 'package:base_project/global/repository/api_service.dart';

class ReplyRepository {
  static final ReplyRepository instance = ReplyRepository._();

  factory ReplyRepository() {
    return instance;
  }

  ReplyRepository._();

  String apiUrl = Env.apiPinReplyUrl;

  Future<ApiResponse<bool>> createPinReply(ModelRequestCreatePinReply requestCreatePinReply) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      Map<String, dynamic> response = await ApiService().post('$apiUrl/create', requestCreatePinReply.toMap());
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

  Future<ApiResponse<ModelResponseGetPinReplies>> getPinReplies(String pinId) async {
    late ModelResponseGetPinReplies modelResponseGetPinReplies;
    try {
      Map<String, dynamic> response = await ApiService().get('$apiUrl/get/replies/$pinId');
      modelResponseGetPinReplies = ModelResponseGetPinReplies.fromMap(response);
      if (modelResponseGetPinReplies.success == true) {
        return ApiResponse.completed(modelResponseGetPinReplies);
      } else {
        return ApiResponse.error(modelResponseGetPinReplies.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
