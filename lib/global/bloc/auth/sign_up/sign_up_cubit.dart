import 'package:base_project/global/model/account/response/me_result.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/user/model_request_sign_up.dart';
import 'package:base_project/global/model/user/model_response_sign_in.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:base_project/global/util/simple_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(String email, String password, String name) async {
    try {
      emit(SignUpLoading());
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? fbUser = authResult.user;

      ModelRequestSignUp modelRequestSignUp = ModelRequestSignUp(
        uid: fbUser?.uid.toString() ?? '',
        email: fbUser?.email ?? '',
        social: 'email',
        name: name,
        password: password,
        profileImage: '',
      );

      // 서버에 가입 호출
      ApiResponse<bool> response =
          await AuthRepository.instance.signUp(modelRequestSignUp.toMap());
      if (response.status == ResponseStatus.error) {
        emit(
          SignUpError(errorMessage: response.message ?? 'sign Up error'),
        );
      }

      // firebase 유저 가져와서 서버에 로그인 합니다.
      ApiResponse<ModelSignIn> responseSignIn =
          await AuthRepository.instance.signIn(fbUser!.email ?? '', password);
      if (responseSignIn.status == ResponseStatus.error) {
        emit(
          SignUpError(errorMessage: responseSignIn.message ?? 'sign Up error'),
        );
      }

      ApiResponse<ModelUser> responseUserModel =
          await AuthRepository.instance.getMe();
      if (responseUserModel.status == ResponseStatus.error) {
        emit(SignUpError(
            errorMessage: responseUserModel.message ?? 'get me error'));
      }

      // 로그인까지 끝나면 true
      emit(SignUpLoaded());
    } catch (e) {
      logger.d('error');
      throw Exception();
    }
  }
}
