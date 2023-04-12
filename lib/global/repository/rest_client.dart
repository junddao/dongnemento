import 'package:base_project/global/model/common/data_response.dart';
import 'package:base_project/global/model/pin/model_response_pin.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://192.168.2.40:17008')
abstract class RestClient {
  factory RestClient(
    Dio dio,
  ) = _RestClient;

  @GET('/pin/{id}')
  Future<DataResponse<ModelResponsePin>> getPin(@Path("id") String id);
}
