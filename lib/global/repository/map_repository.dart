import 'package:base_project/env.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/common/model_response_common.dart';
import 'package:base_project/global/model/etc/kakao_local_result.dart';
import 'package:base_project/global/model/etc/model_response_kakao_location.dart';
import 'package:base_project/global/model/pin/model_request_create_pin.dart';
import 'package:base_project/global/model/pin/model_request_get_pin.dart';
import 'package:base_project/global/model/pin/model_response_get_pin.dart';
import 'package:base_project/global/repository/api_service.dart';

class MapRepository {
  static final MapRepository instance = MapRepository._();

  factory MapRepository() {
    return instance;
  }

  MapRepository._();

  String apiUrl = Env.apiMapUrl;

  Future<KakaoLocalResponseData> getKakaoAddressByKeyword(String keyword,
      {int? page = 15}) async {
    late KakaoLocalResponseData kakaoLocalResponseData;
    try {
      String path =
          'https://dapi.kakao.com/v2/local/search/keyword.json?query=$keyword&page=$page';
      Map<String, dynamic> response = await ApiService().getKakaoApi(path);
      kakaoLocalResponseData = KakaoLocalResponseData.fromMap(response);
      return kakaoLocalResponseData;
    } catch (e) {
      throw Exception();
    }
  }

  Future<ModelResponseKakaoLocation> getKakaoAddressByLocation(
      double lng, double lat) async {
    late ModelResponseKakaoLocation modelResponseKakaoLocation;
    try {
      String path =
          'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$lng&y=$lat';
      Map<String, dynamic> response = await ApiService().getKakaoApi(path);
      modelResponseKakaoLocation = ModelResponseKakaoLocation.fromMap(response);
      return modelResponseKakaoLocation;
    } catch (e) {
      throw Exception();
    }
  }
}
