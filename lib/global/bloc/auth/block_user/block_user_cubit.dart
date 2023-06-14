import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';
import '../../../repository/rest_api_manager.dart';

part 'block_user_state.dart';

class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserCubit() : super(BlockUserInitial());

  Future<void> blockUser(ModelRequestBlock modelRequestBlock) async {
    try {
      emit(BlockUserLoading());

      DataResponse<ModelUser> response = await RestApiManager.instance.getRestClient().blockUser(modelRequestBlock);

      if (response.success == false) {
        emit(BlockUserError(errorMessage: response.error ?? 'report error'));
      } else {
        emit(BlockUserLoaded(user: response.data.first));
      }
    } catch (e) {
      emit(BlockUserError(
        errorMessage: e.toString(),
      ));
    }
  }
}
