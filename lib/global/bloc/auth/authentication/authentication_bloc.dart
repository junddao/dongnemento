import 'package:base_project/global/enum/authentication_status_type.dart';
import 'package:base_project/global/enum/social_type.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';
import '../../../util/util.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
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
    try {
      switch (event.status) {
        case AuthenticationStatusType.unauthenticated:
          add(AuthenticationSignOut());

          emit(const AuthenticationUnAuthenticated());
          break;
        case AuthenticationStatusType.authenticated:
          final dio = Dio(); // Provide a dio instance
          dio.interceptors.add(TokenInterceptor(RestClient(dio)));
          DataResponse<ModelUser> responseModelUser = await RestClient(dio, baseUrl: endPoint).getMe();

          if (responseModelUser.success == false) {
            emit(
              AuthenticationError(errorMessage: responseModelUser.error ?? 'get me error'),
            );
          } else {
            ModelUser me = responseModelUser.data.first;

            emit(AuthenticationAuthenticated(me: me));
          }

          break;
        default:
          emit(const AuthenticationUnknown());
      }
    } catch (e) {
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

      late DataResponse<ModelGetToken> responseModelSignIn;

      //signIn
      switch (event.socialType) {
        case SocialType.email:
          responseModelSignIn = await emailLogin(event.input);
          break;
        case SocialType.kakao:
          responseModelSignIn = await kakaoLogin(event.input);
          break;
        case SocialType.apple:
          responseModelSignIn = await appleLogin(event.input);
          break;
        default:
      }

      if (responseModelSignIn.success == false) {
        emit(
          AuthenticationError(errorMessage: responseModelSignIn.error ?? 'sign in error'),
        );
      } else {
        ModelGetToken modelGetToken = responseModelSignIn.data.first;
        await SecureStorage.instance.writeToken(modelGetToken.accessToken);
      }

      //get me
      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<ModelUser> responseModelUser = await RestClient(dio, baseUrl: endPoint).getMe();

      if (responseModelUser.success == false) {
        emit(
          AuthenticationError(errorMessage: responseModelUser.error ?? 'get me error'),
        );
      }
      ModelUser? me = responseModelUser.data.first;
      // SecureStorage.instance.writeMe(me);
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

  Future<DataResponse<ModelGetToken>> emailLogin(Map<String, dynamic> input) async {
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(TokenInterceptor(RestClient(dio)));
    DataResponse<ModelGetToken> response = await RestClient(dio, baseUrl: endPoint).signIn(input);

    return response;
  }

  Future<DataResponse<ModelGetToken>> kakaoLogin(Map<String, dynamic> input) async {
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(TokenInterceptor(RestClient(dio)));
    DataResponse<ModelGetToken> response = await RestClient(dio, baseUrl: endPoint).kakaoSignIn(input);

    return response;
  }

  Future<DataResponse<ModelGetToken>> appleLogin(Map<String, dynamic> input) async {
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(TokenInterceptor(RestClient(dio)));
    DataResponse<ModelGetToken> response = await RestClient(dio, baseUrl: endPoint).appleSignIn(input);

    return response;
  }
}
