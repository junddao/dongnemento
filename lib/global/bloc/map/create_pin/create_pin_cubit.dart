import 'package:base_project/global/model/common/data_response.dart';
import 'package:base_project/global/model/pin/model_request_create_pin.dart';
import 'package:base_project/global/repository/rest_client.dart';
import 'package:base_project/global/repository/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/simple_logger.dart';
import '../../../util/util.dart';

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit() : super(CreatePinInitial());

  Future<void> createPin(ModelRequestCreatePin requestCreatePin) async {
    try {
      emit(CreatePinLoading());

      final dio = Dio();
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<bool> response = await RestClient(dio, baseUrl: endPoint).createPin(requestCreatePin);

      if (response.success == true) {
        emit(CreatePinLoaded(result: response.data.first));
      } else {
        emit(CreatePinError(errorMessage: response.error ?? 'create pin error'));
      }
    } catch (e) {
      logger.d(e);
      emit(
        CreatePinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
