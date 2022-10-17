import 'package:base_project/global/enum/authentication_status_type.dart';
import 'package:base_project/global/enum/social_type.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/user/model_response_sign_in.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static ModelUser? singletonMe;
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
        ApiResponse<ModelUser> responseModelUser =
            await AuthRepository.instance.getMe();
        if (responseModelUser.status == ResponseStatus.error) {
          emit(
            AuthenticationError(
                errorMessage: responseModelUser.message ?? 'get me error'),
          );
        }
        ModelUser? me = responseModelUser.data!;
        SecureStorage.instance.writeMe(me);
        emit(AuthenticationAuthenticated(me: me));

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

      late ApiResponse<ModelSignIn> responseModelSignIn;

      //signIn
      switch (event.socialType) {
        case SocialType.email:
          responseModelSignIn =
              await emailLogin(event.email ?? '', event.password ?? '');
          break;
        // case SocialType.kakao:
        //   result = await kakaoLogin();
        //   break;
        // case SocialType.apple:
        //   result = await appleLogin();
        //   break;
        default:
      }

      if (responseModelSignIn.status == ResponseStatus.error) {
        emit(
          AuthenticationError(
              errorMessage: responseModelSignIn.message ?? 'sign in error'),
        );
      }

      //get me
      ApiResponse<ModelUser> responseModelUser =
          await AuthRepository.instance.getMe();
      if (responseModelUser.status == ResponseStatus.error) {
        emit(
          AuthenticationError(
              errorMessage: responseModelUser.message ?? 'get me error'),
        );
      }
      ModelUser? me = responseModelUser.data!;
      SecureStorage.instance.writeMe(me);
      emit(AuthenticationAuthenticated(me: me));
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
      // if(me.social == SocialType.kakao.name) await UserApi.instance.unlink();
      await FirebaseAuth.instance.signOut();
      await SecureStorage.instance.removeAll();

      emit(const AuthenticationUnAuthenticated());
    } catch (e) {
      AuthenticationError(errorMessage: e.toString());
    }
  }

  Future<ApiResponse<ModelSignIn>> emailLogin(
      String email, String password) async {
    late ApiResponse<ModelSignIn> result;

    result = await AuthRepository.instance.signIn(email, password);

    return result;
  }

  // Future<ModelResponseSignIn> kakaoLogin() async {
  //  late ModelResponseSignIn result;
  //   try {
  //     result = await AuthRepository.instance.signIn(email, password);
  //   } catch (e) {
  //     result = ModelResponseSignIn(success: false, error: e.toString());
  //   }
  //   return result;
  // }
  // Future<ModelResponseSignIn> appleLogin() async {
  //  late ModelResponseSignIn result;
  //   try {
  //     result = await AuthRepository.instance.signIn(email, password);
  //   } catch (e) {
  //     result = ModelResponseSignIn(success: false, error: e.toString());
  //   }
  //   return result;
  // }

}
