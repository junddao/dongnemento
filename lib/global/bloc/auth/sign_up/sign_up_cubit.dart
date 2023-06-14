import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:base_project/global/util/simple_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';
import '../../../service/secure_storage/secure_storage.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(ModelRequestSignUp modelRequestSignUp) async {
    try {
      emit(SignUpLoading());

      DataResponse<bool> response = await RestApiManager.instance.getRestClient().signUp(modelRequestSignUp);

      if (response.success == false) {
        emit(
          SignUpError(errorMessage: response.error ?? 'sign Up error'),
        );
        return;
      }

      // firebase 유저 가져와서 서버에 로그인 합니다.
      ModelRequestSignUp user = modelRequestSignUp;
      ModelRequestSignIn modelRequestSignIn =
          ModelRequestSignIn(email: user.email, password: user.password, firebaseToken: user.firebaseToken);

      DataResponse<ModelGetToken> responseSignIn =
          await RestApiManager.instance.getRestClient().signIn(modelRequestSignIn.toJson());

      if (responseSignIn.success == false) {
        emit(
          SignUpError(errorMessage: responseSignIn.error ?? 'sign Up error'),
        );
        return;
      } else {
        ModelGetToken modelGetToken = responseSignIn.data.first;
        await SecureStorage.instance.writeToken(modelGetToken.accessToken);
      }

      DataResponse<ModelUser> responseUserModel = await RestApiManager.instance.getRestClient().getMe();

      if (responseUserModel.success == false) {
        emit(SignUpError(errorMessage: responseUserModel.error ?? 'get me error'));
        return;
      }

      // 로그인까지 끝나면 true
      emit(SignUpLoaded());
    } catch (e) {
      logger.d('error');
      throw Exception();
    }
  }
}
