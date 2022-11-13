import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/pin/model_request_create_pin.dart';
import 'package:base_project/global/repository/api_service.dart';
import 'package:base_project/global/repository/map_repository.dart';
import 'package:base_project/global/repository/pin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit() : super(CreatePinInitial());

  Future<void> createPin(ModelRequestCreatePin requestCreatePin) async {
    try {
      emit(CreatePinLoading());

      ApiResponse<bool> response =
          await PinRepository.instance.createPin(requestCreatePin);
      if (response.status == ResponseStatus.error) {
        emit(
          CreatePinError(errorMessage: response.message ?? 'create pin error'),
        );
      } else {
        emit(CreatePinLoaded(result: response.data!));
      }
    } catch (e) {
      emit(
        CreatePinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
