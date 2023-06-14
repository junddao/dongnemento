import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/model.dart';

part 'get_pin_replies_state.dart';

class GetPinRepliesCubit extends Cubit<GetPinRepliesState> {
  GetPinRepliesCubit() : super(GetPinRepliesInitial());

  Future<void> getPinReplies(String pinId) async {
    try {
      emit(GetPinRepliesLoading());

      DataResponse<ModelResponsePinReply> response = await RestApiManager.instance.getRestClient().getPinReplies(pinId);

      if (response.success == true) {
        emit(GetPinRepliesLoaded(result: response.data));
      } else {
        emit(GetPinRepliesError(errorMessage: response.error ?? 'get pin replies error'));
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
