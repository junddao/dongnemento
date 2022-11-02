import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/pin/model_request_create_pin_reply.dart';
import 'package:base_project/global/repository/reply_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_pin_reply_state.dart';

class CreatePinReplyCubit extends Cubit<CreatePinReplyState> {
  CreatePinReplyCubit() : super(CreatePinReplyInitial());

  Future<void> createPinReply(ModelRequestCreatePinReply requestCreatePinReply) async {
    try {
      emit(CreatePinReplyLoading());

      ApiResponse<bool> response = await ReplyRepository.instance.createPinReply(requestCreatePinReply);
      if (response.status == ResponseStatus.error) {
        emit(
          CreatePinReplyError(errorMessage: response.message ?? 'create pin reply error'),
        );
      } else {
        emit(CreatePinReplyLoaded(result: response.data!));
      }
    } catch (e) {
      emit(
        CreatePinReplyError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
