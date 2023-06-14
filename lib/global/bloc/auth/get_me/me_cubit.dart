import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';

part 'me_state.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit() : super(MeInitial());

  ModelUser me = ModelUser();

  Future<void> getMe() async {
    emit(MeLoading());

    DataResponse<ModelUser> response = await RestApiManager.instance.getRestClient().getMe();

    if (response.success == false) {
      emit(
        MeError(errorMessage: response.error ?? 'sign Up error'),
      );
      return;
    }

    me = response.data.first;

    emit(MeLoaded(me: response.data.first));
  }

  Future<void> setMe(ModelUser modelUser) async {
    emit(MeLoading());

    DataResponse<ModelUser> response = await RestApiManager.instance.getRestClient().updateUser(modelUser);

    if (response.success == false) {
      emit(
        MeError(errorMessage: response.error ?? 'update user error'),
      );
      return;
    }

    me = response.data.first;

    emit(MeLoaded(me: response.data.first));
  }
}
