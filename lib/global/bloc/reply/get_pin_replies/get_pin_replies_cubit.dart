import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/reply/model_response_pin_replies.dart';
import 'package:base_project/global/repository/reply_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_pin_replies_state.dart';

class GetPinRepliesCubit extends Cubit<GetPinRepliesState> {
  GetPinRepliesCubit() : super(GetPinRepliesInitial());

  Future<void> getPinReplies(String pinId) async {
    try {
      emit(GetPinRepliesLoading());
      print(pinId);
      ApiResponse<ModelResponseGetPinReplies> response = await ReplyRepository.instance.getPinReplies(pinId);

      if (response.status == ResponseStatus.error) {
        emit(
          GetPinRepliesError(errorMessage: response.message ?? 'get pin replies error'),
        );
      } else {
        emit(GetPinRepliesLoaded(result: response.data!));
      }
    } catch (e) {
      emit(
        GetPinRepliesError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
