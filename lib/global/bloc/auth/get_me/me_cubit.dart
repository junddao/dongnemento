import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';
import '../../../service/secure_storage/secure_storage.dart';
import '../../../util/util.dart';

part 'me_state.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit() : super(MeInitial());

  ModelUser me = ModelUser();

  Future<void> getMe() async {
    emit(MeLoading());

    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(TokenInterceptor(RestClient(dio)));
    DataResponse<ModelUser> response = await RestClient(dio, baseUrl: endPoint).getMe();

    if (response.success == false) {
      emit(
        MeError(errorMessage: response.error ?? 'sign Up error'),
      );
    }

    me = response.data.first;

    emit(MeLoaded(me: response.data.first));
  }

  Future<void> setMe(ModelUser modelUser) async {
    emit(MeLoading());

    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(TokenInterceptor(RestClient(dio)));
    DataResponse<ModelUser> response = await RestClient(dio, baseUrl: endPoint).updateUser(modelUser);

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
