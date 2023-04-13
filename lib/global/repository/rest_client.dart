import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/pin/create')
  Future<DataResponse<bool>> createPin(@Body() ModelRequestCreatePin modelRequestCreatePin);

  @GET('/pin/get/{id}')
  Future<DataResponse<ModelResponsePin>> getPin(@Path("id") String id);

  @GET('/pin/get/pins')
  Future<DataResponse<ModelResponsePins>> getPins(@Queries() Map<String, dynamic> queries);

  @DELETE('/pin/delete/{id}')
  Future<DataResponse<bool>> deletePin(@Path("id") String id);
}
