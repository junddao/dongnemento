import 'package:base_project/global/model/common/data_response.dart';
import 'package:base_project/global/model/pin/model_response_pin.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/pin/get/{id}')
  Future<DataResponse<ModelResponsePin>> getPin(@Path("id") String id);
}
