import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/model.dart';

part 'get_pins_state.dart';

class GetPinsCubit extends Cubit<GetPinsState> {
  GetPinsCubit() : super(GetPinsInitial());

  Future<void> getPins(ModelRequestGetPin modelRequestGetPin) async {
    try {
      emit(GetPinsLoading());

      DataResponse<ModelResponsePins> response =
          await RestApiManager.instance.getRestClient().getPins(modelRequestGetPin.toJson());

      // ApiResponse<ModelResponseGetPin> response = await PinRepository.instance.getPins(modelRequestGetPin);

      if (response.success == true) {
        emit(GetPinsLoaded(result: response.data));
      } else {
        emit(GetPinsError(errorMessage: response.error ?? 'get pin error'));
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
