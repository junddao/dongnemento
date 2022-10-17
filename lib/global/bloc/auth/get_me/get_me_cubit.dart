import 'package:base_project/global/model/account/response/me_result.dart';
import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    SecureStorage.instance.writeMe(response.data!);
    emit(GetMeLoaded());
  }
}
