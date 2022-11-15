import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/like/model_request_set_pin_like.dart';
import 'package:base_project/global/repository/like_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'set_pin_like_state.dart';

class SetPinLikeCubit extends Cubit<SetPinLikeState> {
  SetPinLikeCubit() : super(SetPinLikeInitial());

  Future<void> setPinLike(ModelRequestSetPinLike modelRequestSetPinLike) async {
    try {
      emit(SetPinLikeLoading());

      ApiResponse<bool> response = await LikeRepository.instance.setPinLike(modelRequestSetPinLike);
      if (response.status == ResponseStatus.error) {
        emit(
          SetPinLikeError(errorMessage: response.message ?? 'create pin reply error'),
        );
      } else {
        emit(SetPinLikeLoaded(result: response.data!));
      }
    } catch (e) {
      emit(
        SetPinLikeError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
