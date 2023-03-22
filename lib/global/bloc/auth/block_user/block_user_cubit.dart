import 'package:base_project/global/model/user/model_request_block.dart';
import 'package:base_project/global/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/common/api_response.dart';
import '../../../model/user/model_user.dart';

part 'block_user_state.dart';

class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserCubit() : super(BlockUserInitial());

  Future<void> blockUser(ModelRequestBlock modelRequestBlock) async {
    try {
      emit(BlockUserLoading());

      ApiResponse<ModelUser> response = await AuthRepository.instance.blockUser(modelRequestBlock);

      if (response.status == ResponseStatus.error) {
        emit(BlockUserError(errorMessage: response.message ?? 'report error'));
      } else {
        emit(BlockUserLoaded(user: response.data!));
      }
    } catch (e) {
      emit(BlockUserError(
        errorMessage: e.toString(),
      ));
    }
  }
}
