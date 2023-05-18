import 'package:base_project/global/util/simple_logger.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';
import '../../../service/secure_storage/secure_storage.dart';
import '../../../util/util.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(ModelRequestSignUp modelRequestSignUp) async {
    try {
      emit(SignUpLoading());

      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<bool> response = await RestClient(dio, baseUrl: endPoint).signUp(modelRequestSignUp);

      if (response.success == false) {
        emit(
          SignUpError(errorMessage: response.error ?? 'sign Up error'),
        );
      }

      // firebase 유저 가져와서 서버에 로그인 합니다.
      ModelRequestSignUp user = modelRequestSignUp;
      ModelRequestSignIn modelRequestSignIn = ModelRequestSignIn(email: user.email, password: user.password);

      DataResponse<ModelGetToken> responseSignIn =
          await RestClient(dio, baseUrl: endPoint).signIn(modelRequestSignIn.toJson());

      if (responseSignIn.success == false) {
        emit(
          SignUpError(errorMessage: responseSignIn.error ?? 'sign Up error'),
        );
      } else {
        ModelGetToken modelGetToken = responseSignIn.data.first;
        await SecureStorage.instance.writeToken(modelGetToken.accessToken);
      }

      DataResponse<ModelUser> responseUserModel = await RestClient(dio, baseUrl: endPoint).getMe();

      if (responseUserModel.success == false) {
        emit(SignUpError(errorMessage: responseUserModel.error ?? 'get me error'));
      }

      // 로그인까지 끝나면 true
      emit(SignUpLoaded());
    } catch (e) {
      logger.d('error');
      throw Exception();
    }
  }
}
