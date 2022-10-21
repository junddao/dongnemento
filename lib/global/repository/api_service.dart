import 'dart:convert';
import 'dart:io';

import 'package:base_project/global/model/etc/kakao_local_result.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:base_project/global/util/simple_logger.dart';
import 'package:dio/dio.dart';

class ApiService {
  static String appVersion = '';
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  final Map<String, String> _kakaoHeader = {
    'Content-Type': 'application/json',
    'Authorization': 'KakaoAK ddf47dd3cff3564342e4770cb40cc057',
  };

  final Map<String, String> _multiPartHeaders = {
    'Content-Type': 'multipart/form-data',
  };

  Future<dynamic> getKakaoApi(path) async {
    Response response;
    try {
      response = await Dio()
          .get(path,
              options: Options(
                headers: _kakaoHeader,
              ))
          .timeout(const Duration(seconds: 10));

      logger.d('dio response = ${response.toString()}');
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      throw errorMessage;
    } on SocketException {
      logger.d('No network');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw CustomException('Unknown Error');
    }
    return response.data;
  }

  Future<dynamic> getKakaoAddressByLocation(double lng, double lat) async {
    Response response;
    try {
      response = await Dio()
          .get(
              'https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=$lng&y=$lat',
              options: Options(
                headers: _kakaoHeader,
              ))
          .timeout(const Duration(seconds: 10));

      logger.d('dio response = ${response.toString()}');
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      throw errorMessage;
    } on SocketException {
      logger.d('No network');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw CustomException('Unknown Error');
    }
    return KakaoLocalResponseData.fromMap(response.data);
  }

  Future<dynamic> get(String url, {bool useToken = true}) async {
    logger.d('Api get : url $url start.');
    Response response;
    try {
      if (useToken) {
        final token = await _getAuthorizationToken();
        _headers['Authorization'] = 'Bearer $token';
        logger.d(token);
      }

      response = await Dio()
          .get(url,
              options: Options(
                headers: _headers,
              ))
          .timeout(const Duration(seconds: 10));
      logger.d('Api get : url $url  done.');
      logger.d('dio response = ${response.toString()}');
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      throw errorMessage;
    } on SocketException {
      logger.d('No network');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw CustomException('Unknown Error');
    }
    return response.data;
  }

  Future<dynamic> post(String url, Map map, {bool useToken = true}) async {
    logger.d('Api post : url $url start.');

    Response response;
    try {
      if (useToken) {
        final token = await _getAuthorizationToken();
        _headers['Authorization'] = 'Bearer $token';
        logger.d(token);
      }

      var data = jsonEncode(map);

      response = await Dio()
          .post(
            url,
            data: data,
            options: Options(
              headers: _headers,
            ),
          )
          .timeout(const Duration(seconds: 10));

      logger.d('Api Post : url $url  done.');
      logger.d('dio response = ${response.toString()}');
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      throw errorMessage;
    } on SocketException {
      logger.d('No network');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw CustomException('Unknown Error');
    }
    return response.data;
  }

  Future<dynamic> postMultiPart(
      String url, List<File> files, Map<String, dynamic> map) async {
    final token = await _getAuthorizationToken();
    logger.d(token);

    Response response;
    try {
      _multiPartHeaders['Authorization'] = 'Bearer $token';
      final formData = FormData.fromMap(map);

      // formData.fields.add(MapEntry('roomId', roomId));
      // formData.fields.add(MapEntry('syncKey', generateSyncKey()));
      for (int i = 0; i < files.length; i++) {
        formData.files.add(
          MapEntry(
            'files',
            await MultipartFile.fromFile(files[i].path),
          ),
        );
      }

      logger.d(url);
      response = await Dio().post(
        url,
        data: formData,
        options: Options(
          headers: _multiPartHeaders,
        ),
        onSendProgress: (int sent, int total) {
          // progress 필요할때 쓰면 됩니다.
          if (sent < total) {
          } else {}
        },
      ).timeout(const Duration(seconds: 30));

      logger.d('Api MultipartPost : url $url  done.');
      logger.d('dio response = ${response.toString()}');
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      throw errorMessage;
    } on SocketException {
      logger.d('No network');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw CustomException('Unknown Error');
    }
    return response.data;
  }

  Future<String?> _getAuthorizationToken() async {
    String? token = await SecureStorage.instance.readToken();

    return token;
  }

  // Future<void> getRefreshToken() async {
  //   var jwt = await SecureStorage.instance.readToken();
  //   final variables = {
  //     "input": {
  //       "refreshToken": jwt?.refreshToken,
  //     },
  //   };

  //   String key = "refreshSign";

  //   // GQLOperation query = refreshSign_syntax;
  //   // QueryResult result = await _client(Env.apiAuthUrl, jwt?.token).mutate(query.toMutationOption(
  //   //   variables: variables,
  //   // ));
  //   // if (result.hasException) {
  //   //   Singleton().mode = AuthStatus.unknown;
  //   //   Bloc bloc = ModeChangeBloc();
  //   //   bloc.add(ModeChangeRequested());
  //   // } else {
  //   //   var data = result.data![key];

  //   //   final SignInResult reFresh = SignInResult.fromMap(data!);

  //   //   LocalRepository().writeJWT(reFresh);
  //   // }
  // }
}

class DioException implements Exception {
  late String errorMessage;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioErrorType.connectTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioErrorType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioErrorType.response:
        errorMessage = _handleStatusCode(dioError.response?.statusCode);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errorMessage = 'No Internet.';
          break;
        }
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMessage;
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "");
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}
