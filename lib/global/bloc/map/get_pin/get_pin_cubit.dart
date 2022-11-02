import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/pin/model_response_get_pin.dart';
import 'package:base_project/global/repository/pin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_pin_state.dart';

class GetPinCubit extends Cubit<GetPinState> {
  GetPinCubit() : super(GetPinInitial());

  Future<void> getPin(String pinId) async {
    try {
      emit(GetPinLoading());

      ApiResponse<ModelResponseGetPin> response =
          await PinRepository.instance.getPin(pinId);

      if (response.status == ResponseStatus.error) {
        emit(
          GetPinError(errorMessage: response.message ?? 'get pin error'),
        );
      } else {
        emit(GetPinLoaded(result: response.data!));
      }
    } catch (e) {
      emit(
        GetPinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
