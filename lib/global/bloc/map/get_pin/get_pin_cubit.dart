import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';

part 'get_pin_state.dart';

class GetPinCubit extends Cubit<GetPinState> {
  GetPinCubit() : super(GetPinInitial());

  Future<void> getPin(String pinId) async {
    try {
      emit(GetPinLoading());

      DataResponse<ModelResponsePin> response = await RestApiManager.instance.getRestClient().getPin(pinId);

      if (response.success == true) {
        emit(GetPinLoaded(result: response.data.first));
      } else {
        emit(GetPinError(errorMessage: response.error ?? 'get pin error'));
      }
    } catch (e) {
      emit(
        GetPinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> setPinLike(ModelRequestSetPinLike modelRequestSetPinLike, bool isLiked) async {
    try {
      // emit(SetPinLikeLoading());

      DataResponse<bool> response = await RestApiManager.instance.getRestClient().setPinLike(modelRequestSetPinLike);

      if (response.success == true) {
        if (state is GetPinLoaded) {
          ModelResponsePin prevResult = (state as GetPinLoaded).result;
          late ModelResponsePin newPin;
          if (isLiked) {
            newPin = prevResult.copyWith(
              isLiked: true,
              likeCount: (prevResult.likeCount ?? 0) + 1,
            );
          } else {
            newPin = prevResult.copyWith(
              isLiked: false,
              likeCount: (prevResult.likeCount ?? 0) - 1,
            );
          }

          emit(GetPinLoaded(result: newPin));
        }
      } else {
        emit(
          GetPinError(errorMessage: response.error ?? 'create pin like error'),
        );
      }
    } catch (e) {
      emit(
        GetPinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> setPinHate(ModelRequestSetPinHate modelRequestSetPinHate, bool isHated) async {
    try {
      DataResponse<bool> response = await RestApiManager.instance.getRestClient().setPinHate(modelRequestSetPinHate);

      if (response.success == true) {
        if (state is GetPinLoaded) {
          ModelResponsePin prevResult = (state as GetPinLoaded).result;
          late ModelResponsePin newPin;
          if (isHated) {
            newPin = prevResult.copyWith(
              isHated: true,
              hateCount: (prevResult.hateCount ?? 0) + 1,
            );
          } else {
            newPin = prevResult.copyWith(
              isHated: false,
              hateCount: (prevResult.hateCount ?? 0) - 1,
            );
          }

          emit(GetPinLoaded(result: newPin));
        }
      } else {
        emit(
          GetPinError(errorMessage: response.error ?? 'create pin hate error'),
        );
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
