import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../env.dart';
import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';
import '../../../service/secure_storage/secure_storage.dart';

part 'me_state.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit() : super(MeInitial());

  ModelUser me = ModelUser();

  Future<void> getMe() async {
    emit(MeLoading());

    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(TokenInterceptor(RestClient(dio)));
    DataResponse<ModelUser> response = await RestClient(dio, baseUrl: Env.apiBaseUrl).getMe();

    if (response.success == false) {
      emit(
        MeError(errorMessage: response.error ?? 'sign Up error'),
      );
    }

    me = response.data.first;
    await SecureStorage.instance.writeMe(me);

    emit(MeLoaded(me: response.data.first));
  }

  void setMe(ModelUser user) async {
    emit(MeLoading());
    me = user;
    await SecureStorage.instance.writeMe(me);
    emit(MeLoaded(me: me));
  }

  Future<void> updateUser(ModelUser modelUser) async {
    emit(MeLoading());

    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(TokenInterceptor(RestClient(dio)));
    DataResponse<ModelUser> response = await RestClient(dio, baseUrl: Env.apiBaseUrl).updateUser(modelUser);

    if (response.success == false) {
      emit(
        MeError(errorMessage: response.error ?? 'update user error'),
      );
    }

    me = response.data.first;
    await SecureStorage.instance.writeMe(me);

    emit(MeLoaded(me: response.data.first));
  }
}
