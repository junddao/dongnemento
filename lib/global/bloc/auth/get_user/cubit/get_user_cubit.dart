import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/model.dart';
import '../../../../repository/rest_api_manager.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());

  Future<void> getUser(String id) async {
    try {
      emit(GetUserLoading());

      DataResponse<ModelUser> response = await RestApiManager.instance.getRestClient().getUser(id);

      if (response.success == false) {
        emit(GetUserError(errorMessage: response.error ?? 'report error'));
      } else {
        emit(GetUserLoaded(user: response.data.first));
      }
    } catch (e) {
      emit(GetUserError(
        errorMessage: e.toString(),
      ));
    }
  }
}
