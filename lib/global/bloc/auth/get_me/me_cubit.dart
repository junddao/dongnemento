import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/secure_storage/secure_storage.dart';

part 'me_state.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit() : super(MeInitial());

  late ModelUser me;

  Future<void> getMe() async {
    emit(MeLoading());
    ApiResponse<ModelUser> response = await AuthRepository.instance.getMe();
    if (response.status == ResponseStatus.error) {
      emit(
        MeError(errorMessage: response.message ?? 'sign Up error'),
      );
    }

    me = response.data!;
    await SecureStorage.instance.writeMe(me);

    emit(MeLoaded(me: response.data!));
  }

  Future<void> updateUser(Map<String, dynamic> map) async {
    emit(MeLoading());

    ApiResponse<ModelUser> response = await AuthRepository.instance.updateUser(map);
    if (response.status == ResponseStatus.error) {
      emit(
        MeError(errorMessage: response.message ?? 'update user error'),
      );
    }

    me = response.data!;
    await SecureStorage.instance.writeMe(me);

    emit(MeLoaded(me: response.data!));
  }
}
