import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';
import '../../../util/util.dart';

part 'get_pin_state.dart';

class GetPinCubit extends Cubit<GetPinState> {
  GetPinCubit() : super(GetPinInitial());

  Future<void> getPin(String pinId) async {
    try {
      emit(GetPinLoading());

      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<ModelResponsePin> response = await RestClient(dio, baseUrl: endPoint).getPin(pinId);

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

      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<bool> response = await RestClient(dio, baseUrl: endPoint).setPinLike(modelRequestSetPinLike);

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
      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<bool> response = await RestClient(dio, baseUrl: endPoint).setPinHate(modelRequestSetPinHate);

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
