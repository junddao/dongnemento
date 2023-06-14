import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/model.dart';

part 'get_my_pins_state.dart';

class GetMyPinsCubit extends Cubit<GetMyPinsState> {
  GetMyPinsCubit() : super(GetMyPinsInitial());

  Future<void> getMyPins() async {
    try {
      emit(GetMyPinsLoading());

      DataResponse<ModelResponsePins> response = await RestApiManager.instance.getRestClient().getMyPins();

      // ApiResponse<ModelResponseGetPin> response = await PinRepository.instance.getPins(modelRequestGetPin);

      if (response.success == true) {
        emit(GetMyPinsLoaded(result: response.data));
      } else {
        emit(GetMyPinsError(errorMessage: response.error ?? 'get pin error'));
      }
    } catch (e) {
      emit(
        GetMyPinsError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
