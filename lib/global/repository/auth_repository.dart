import 'package:base_project/env.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/common/model_response_common.dart';
import 'package:base_project/global/model/user/model_request_get_token.dart';
import 'package:base_project/global/model/user/model_request_sign_in.dart';
import 'package:base_project/global/model/user/model_response_me.dart';
import 'package:base_project/global/model/user/model_response_sign_in.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/api_service.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';

class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();

  factory AuthRepository() {
    return instance;
  }
  AuthRepository._internal();

  String apiUrl = Env.apiAuthUrl;

  Future<ApiResponse<ModelSignIn>> signIn(String email, String password) async {
    late ModelResponseSignIn modelResponseSignIn;
    try {
      ModelRequestSignIn modelRequestSignIn =
          ModelRequestSignIn(email: email, password: password);
      String url = '$apiUrl/signin';
      Map<String, dynamic> response = await ApiService()
          .post(url, modelRequestSignIn.toMap(), useToken: false);
      modelResponseSignIn = ModelResponseSignIn.fromMap(response);
      if (modelResponseSignIn.success == true) {
        ModelSignIn modelSignIn = modelResponseSignIn.data!.first;
        await SecureStorage.instance.writeToken(modelSignIn.accessToken);
        return ApiResponse.completed(modelSignIn);
      } else {
        return ApiResponse.error(modelResponseSignIn.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<String>> kakaoSignIn(Map<String, dynamic> user) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      String url = '$apiUrl/kakao';
      Map<String, dynamic> response =
          await ApiService().post(url, user, useToken: false);
      modelResponseCommon = ModelResponseCommon.fromMap(response);
      if (modelResponseCommon.success == true) {
        final customTokenResponse = response['data'].first;
        return ApiResponse.completed(customTokenResponse['fbCustomToken']);
      } else {
        return ApiResponse.error(modelResponseCommon.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<ModelResponseSignIn>> getToken(String email) async {
    late ModelResponseSignIn modelResponseSignIn;

    try {
      ModelRequestGetToken modelRequestGetToken =
          ModelRequestGetToken(email: email);

      String url = '$apiUrl/get/token';
      Map<String, dynamic> response = await ApiService()
          .post(url, modelRequestGetToken.toMap(), useToken: false);
      modelResponseSignIn = ModelResponseSignIn.fromMap(response);
      if (modelResponseSignIn.success == true) {
        ModelSignIn modelSignIn = modelResponseSignIn.data!.first;
        await SecureStorage.instance.writeToken(modelSignIn.accessToken);
        return ApiResponse.completed(modelResponseSignIn);
      } else {
        return ApiResponse.error(modelResponseSignIn.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<String>> appleSignIn(Map<String, dynamic> user) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      String url = '$apiUrl/apple';

      Map<String, dynamic> response =
          await ApiService().post(url, user, useToken: false);
      modelResponseCommon = ModelResponseCommon.fromMap(response);
      if (modelResponseCommon.success == true) {
        final customTokenResponse = response['data'].first;
        return ApiResponse.completed(customTokenResponse['fbCustomToken']);
      } else {
        return ApiResponse.error(modelResponseCommon.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<ModelUser>> getMe() async {
    late ModelResponseMe modelResponseMe;
    try {
      String path = '$apiUrl/me';
      Map<String, dynamic> response = await ApiService().get(path);
      modelResponseMe = ModelResponseMe.fromMap(response);
      if (modelResponseMe.success == true) {
        ModelUser modelUser = modelResponseMe.data!.first;
        return ApiResponse.completed(modelUser);
      } else {
        throw Exception(modelResponseMe.error);
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<bool>> signUp(Map<String, dynamic> map) async {
    late ModelResponseCommon modelResponseCommon;
    try {
      String url = '$apiUrl/signup';
      Map<String, dynamic> response =
          await ApiService().post(url, map, useToken: false);
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
