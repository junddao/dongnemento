import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/pin/model_request_get_pin.dart';
import 'package:base_project/global/model/pin/model_response_get_pin.dart';
import 'package:base_project/global/repository/pin_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'get_pins_state.dart';

class GetPinsCubit extends Cubit<GetPinsState> {
  GetPinsCubit() : super(GetPinsInitial());

  Future<void> getPins(ModelRequestGetPin modelRequestGetPin) async {
    try {
      emit(GetPinsLoading());

      ApiResponse<ModelResponseGetPin> response = await PinRepository.instance.getPins(modelRequestGetPin);

      if (response.status == ResponseStatus.error) {
        emit(
          GetPinsError(errorMessage: response.message ?? 'get pin error'),
        );
      } else {
        emit(GetPinsLoaded(result: response.data!));
      }
    } catch (e) {
      emit(
        GetPinsError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
