import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../env.dart';
import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';

part 'get_pins_state.dart';

class GetPinsCubit extends Cubit<GetPinsState> {
  GetPinsCubit() : super(GetPinsInitial());

  Future<void> getPins(ModelRequestGetPin modelRequestGetPin) async {
    try {
      emit(GetPinsLoading());

      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<ModelResponsePins> response =
          await RestClient(dio, baseUrl: Env.apiBaseUrl).getPins(modelRequestGetPin.toMap());

      // ApiResponse<ModelResponseGetPin> response = await PinRepository.instance.getPins(modelRequestGetPin);

      if (response.success == false) {
        emit(
          GetPinsError(errorMessage: response.error ?? 'get pin error'),
        );
      } else {
        emit(GetPinsLoaded(result: response.data));
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
