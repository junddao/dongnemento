import 'package:base_project/global/enum/state_enum.dart';
import 'package:base_project/global/model/auth/request/sign_in_input.dart';
import 'package:base_project/global/model/auth/response/sign_in_result.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:base_project/global/repository/common/repo_interface.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState._());

  Future<void> signIn(SignInInput input) async {
    try {
      emit(const SignInState.loading());
      DataOrFailure<SignInResult> signInResult = await AuthRepository.instance.signIn(input);

      if (signInResult.isFailed) {
        emit(SignInState.failure(message: signInResult.failure.msg));
      }

      await SecureStorage.instance.writeToken(signInResult.data!.signIn);
      emit(SignInState.success(result: signInResult.data));
    } catch (e) {
      emit(SignInState.failure(message: e.toString()));
    }
  }
}
