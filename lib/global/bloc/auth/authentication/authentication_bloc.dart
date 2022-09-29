import 'package:base_project/global/enum/authentication_status_type.dart';
import 'package:base_project/global/model/account/response/me_result.dart';
import 'package:base_project/global/model/auth/request/sign_in_input.dart';
import 'package:base_project/global/model/auth/response/sign_in_result.dart';
import 'package:base_project/global/model/auth/response/sign_out_result.dart';
import 'package:base_project/global/repository/accounts_repository.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:base_project/global/repository/common/repo_interface.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  Me? singletonMe;
  AuthenticationBloc() : super(const AuthenticationInitial()) {
    on<AuthenticationStatusChanged>(
      (event, emit) async {
        await _onAuthenticationStatusChanged(event, emit);
      },
    );
    on<AuthenticationSignIn>(
      (event, emit) async {
        await _onAuthenticationSignIn(event, emit);
      },
    );
    on<AuthenticationSignOut>(
      (event, emit) async {
        await _onAuthenticationSignOut(event, emit);
      },
    );
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatusType.unauthenticated:
        if (singletonMe != null) {
          add(AuthenticationSignOut());
        } else {
          await SecureStorage.instance.removeAll();
        }

        emit(const AuthenticationUnAuthenticated());
        break;
      case AuthenticationStatusType.authenticated:
        DataOrFailure<MeResult> meResult = await _getMe();
        if (meResult.isFailed) {
          emit(const AuthenticationUnAuthenticated());
          break;
        }

        emit(AuthenticationAuthenticated(me: meResult.data));
        break;
      default:
        emit(const AuthenticationUnknown());
    }
  }

  Future<void> _onAuthenticationSignIn(
    AuthenticationSignIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(
        const AuthenticationLoading(),
      );

      //signIn
      SignInInput input = event.input;
      DataOrFailure<SignInResult> signInResult = await AuthRepository.instance.signIn(input);

      if (signInResult.isFailed) {
        emit(
          AuthenticationError(errorMessage: signInResult.failure.msg),
        );
      }

      await SecureStorage.instance.writeToken(signInResult.data!.signIn);

      //get me
      DataOrFailure<MeResult> meResult = await _getMe();
      if (meResult.isFailed) {
        emit(
          AuthenticationError(errorMessage: meResult.failure.msg),
        );
      }

      emit(AuthenticationAuthenticated(me: meResult.data));
    } catch (e) {
      AuthenticationError(errorMessage: e.toString());
    }
  }

  Future<void> _onAuthenticationSignOut(
    AuthenticationSignOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(const AuthenticationLoading());

      DataOrFailure<SignOutResult> signOutResult = await AuthRepository.instance.signOut();

      if (signOutResult.isFailed) {
        emit(
          AuthenticationError(errorMessage: signOutResult.failure.msg),
        );
      }

      await SecureStorage.instance.removeAll();

      emit(const AuthenticationUnAuthenticated());
    } catch (e) {
      AuthenticationError(errorMessage: e.toString());
    }
  }

  Future<DataOrFailure<MeResult>> _getMe() async {
    DataOrFailure<MeResult> meResult = await AccountRepository.instance.me();
    if (meResult.isSuccess) {
      await SecureStorage.instance.writeMe(meResult.data!.me);
      singletonMe = meResult.data!.me;
    }
    return meResult;
  }
}
