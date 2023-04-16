import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/user/me')
  Future<DataResponse<ModelUser>> getMe();

  // @GET('user/all')
  // Future<DataResponse<List<ModelUser>>> getAllUsers();

  @GET('/user/get/{id}')
  Future<DataResponse<ModelUser>> getUser(@Path("id") String id);

  @POST('/user/signup')
  Future<DataResponse<bool>> signUp(@Body() ModelRequestSignUp modelRequestSignUp);

  @POST('/user/signin')
  Future<DataResponse<ModelGetToken>> signIn(@Body() Map<String, dynamic> modelRequestSignIn);

  @POST('/user/kakao')
  Future<DataResponse<ModelGetToken>> kakaoSignIn(@Body() Map<String, dynamic> user);

  @POST('/user/apple')
  Future<DataResponse<ModelGetToken>> appleSignIn(@Body() Map<String, dynamic> user);

  @POST('/user/get/token')
  Future<DataResponse<ModelGetToken>> getToken(@Body() ModelRequestGetToken modelRequestGetToken);

  @POST('/user/update')
  Future<DataResponse<ModelUser>> updateUser(@Body() ModelUser modelUser);

  @POST('/user/block')
  Future<DataResponse<ModelUser>> blockUser(@Body() ModelRequestBlock modelRequestBlock);

  @POST('/pin/create')
  Future<DataResponse<bool>> createPin(@Body() ModelRequestCreatePin modelRequestCreatePin);

  @GET('/pin/get/{id}')
  Future<DataResponse<ModelResponsePin>> getPin(@Path("id") String id);

  @GET('/pin/get/pins')
  Future<DataResponse<ModelResponsePins>> getPins(@Queries() Map<String, dynamic> queries);

  @DELETE('/pin/delete/{id}')
  Future<DataResponse<bool>> deletePin(@Path("id") String id);

  @POST('/reply/create')
  Future<DataResponse<bool>> createPinReply(@Body() ModelRequestCreatePinReply modelRequestCreatePinReply);

  @GET('/reply/get/replies/{id}')
  Future<DataResponse<ModelResponsePinReply>> getPinReplies(@Path("id") String id);

  @POST('/like/pin')
  Future<DataResponse<bool>> setPinLike(@Body() ModelRequestSetPinLike modelRequestSetPinLike);

  @POST('/hate/pin')
  Future<DataResponse<bool>> setPinHate(@Body() ModelRequestSetPinHate modelRequestSetPinHate);

  @POST('/report/create')
  Future<DataResponse<bool>> createReport(@Body() ModelRequestReport modelRequestReport);
}
