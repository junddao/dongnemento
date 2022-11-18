import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());

  Future<void> updateUser(Map<String, dynamic> map) async {
    emit(UpdateUserLoading());

    ApiResponse<ModelUser> response = await AuthRepository.instance.updateUser(map);
    if (response.status == ResponseStatus.error) {
      emit(
        UpdateUserError(errorMessage: response.message ?? 'update user error'),
      );
    }

    emit(UpdateUserLoaded());
  }
}
