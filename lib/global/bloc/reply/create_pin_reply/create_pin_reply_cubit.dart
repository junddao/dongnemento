import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';

part 'create_pin_reply_state.dart';

class CreatePinReplyCubit extends Cubit<CreatePinReplyState> {
  CreatePinReplyCubit() : super(CreatePinReplyInitial());

  Future<void> createPinReply(ModelRequestCreatePinReply requestCreatePinReply) async {
    try {
      emit(CreatePinReplyLoading());

      DataResponse<bool> response = await RestApiManager.instance.getRestClient().createPinReply(requestCreatePinReply);

      if (response.success == true) {
        emit(CreatePinReplyLoaded(result: response.data.first));
      } else {
        emit(CreatePinReplyError(errorMessage: response.error ?? 'create pin reply error'));
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
