import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../env.dart';
import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';

part 'get_my_pins_state.dart';

class GetMyPinsCubit extends Cubit<GetMyPinsState> {
  GetMyPinsCubit() : super(GetMyPinsInitial());

  Future<void> getMyPins() async {
    try {
      emit(GetMyPinsLoading());

      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<ModelResponsePins> response = await RestClient(dio, baseUrl: Env.apiBaseUrl).getMyPins();

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
