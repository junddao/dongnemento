import 'package:base_project/global/model/common/data_response.dart';
import 'package:base_project/global/model/pin/model_request_update_pin.dart';
import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_pin_state.dart';

class UpdatePinCubit extends Cubit<UpdatePinState> {
  UpdatePinCubit() : super(UpdatePinInitial());

  Future<void> updatePin(ModelRequestUpdatePin input, String id) async {
    try {
      emit(UpdatePinLoading());

      DataResponse<bool> response = await RestApiManager.instance.getRestClient().updatePin(input, id);

      if (response.success == true) {
        emit(UpdatePinLoaded(result: response.data.first));
      } else {
        emit(UpdatePinError(errorMessage: response.error ?? 'get pin error'));
      }
    } catch (e) {
      emit(
        UpdatePinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
