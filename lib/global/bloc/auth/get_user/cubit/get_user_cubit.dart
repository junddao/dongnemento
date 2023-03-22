import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/common/api_response.dart';
import '../../../../model/user/model_user.dart';
import '../../../../repository/auth_repository.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());

  Future<void> getUser(String id) async {
    try {
      emit(GetUserLoading());

      ApiResponse<ModelUser> response = await AuthRepository.instance.getUser(id);

      if (response.status == ResponseStatus.error) {
        emit(GetUserError(errorMessage: response.message ?? 'report error'));
      } else {
        emit(GetUserLoaded(user: response.data!));
      }
    } catch (e) {
      emit(GetUserError(
        errorMessage: e.toString(),
      ));
    }
  }
}
