import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_me_state.dart';

class GetMeCubit extends Cubit<GetMeState> {
  GetMeCubit() : super(GetMeInitial());

  Future<void> getMe() async {
    emit(GetMeLoading());
    ApiResponse<ModelUser> response = await AuthRepository.instance.getMe();
    if (response.status == ResponseStatus.error) {
      emit(
        GetMeError(errorMessage: response.message ?? 'sign Up error'),
      );
    }

    emit(GetMeLoaded(me: response.data!));
  }
}
