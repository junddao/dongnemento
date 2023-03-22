import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/user/model_request_sign_up.dart';
import 'package:base_project/global/model/user/model_response_sign_in.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:base_project/global/util/simple_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user/model_request_sign_in.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(Map<String, dynamic> input) async {
    try {
      emit(SignUpLoading());

      // 서버에 가입 호출
      ApiResponse<bool> response = await AuthRepository.instance.signUp(input);
      if (response.status == ResponseStatus.error) {
        emit(
          SignUpError(errorMessage: response.message ?? 'sign Up error'),
        );
      }

      // firebase 유저 가져와서 서버에 로그인 합니다.
      ModelRequestSignUp user = ModelRequestSignUp.fromMap(input);
      ModelRequestSignIn modelRequestSignIn = ModelRequestSignIn(email: user.email, password: user.password);
      ApiResponse<ModelSignIn> responseSignIn = await AuthRepository.instance.signIn(modelRequestSignIn.toMap());
      if (responseSignIn.status == ResponseStatus.error) {
        emit(
          SignUpError(errorMessage: responseSignIn.message ?? 'sign Up error'),
        );
      }

      ApiResponse<ModelUser> responseUserModel = await AuthRepository.instance.getMe();
      if (responseUserModel.status == ResponseStatus.error) {
        emit(SignUpError(errorMessage: responseUserModel.message ?? 'get me error'));
      }

      // 로그인까지 끝나면 true
      emit(SignUpLoaded());
    } catch (e) {
      logger.d('error');
      throw Exception();
    }
  }
}
