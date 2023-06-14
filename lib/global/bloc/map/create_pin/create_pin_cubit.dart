import 'package:base_project/global/model/common/data_response.dart';
import 'package:base_project/global/model/pin/model_request_create_pin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/rest_api_manager.dart';
import '../../../util/simple_logger.dart';

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit() : super(CreatePinInitial());

  Future<void> createPin(ModelRequestCreatePin requestCreatePin) async {
    try {
      emit(CreatePinLoading());

      DataResponse<bool> response = await RestApiManager.instance.getRestClient().createPin(requestCreatePin);

      if (response.success == true) {
        emit(CreatePinLoaded(result: response.data.first));
      } else {
        emit(CreatePinError(errorMessage: response.error ?? 'create pin error'));
      }
    } catch (e) {
      logger.d(e);
      emit(
        CreatePinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
