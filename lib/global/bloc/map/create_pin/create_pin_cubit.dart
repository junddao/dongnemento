import 'package:base_project/global/model/common/data_response.dart';
import 'package:base_project/global/model/pin/model_request_create_pin.dart';
import 'package:base_project/global/repository/rest_client.dart';
import 'package:base_project/global/repository/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../env.dart';

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit() : super(CreatePinInitial());

  Future<void> createPin(ModelRequestCreatePin requestCreatePin) async {
    try {
      emit(CreatePinLoading());

      final dio = Dio();
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<bool> response = await RestClient(dio, baseUrl: Env.apiBaseUrl).createPin(requestCreatePin);

      if (response.success == true) {
        emit(
          CreatePinError(errorMessage: response.error ?? 'create pin error'),
        );
      } else {
        emit(CreatePinLoaded(result: response.data.first));
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
