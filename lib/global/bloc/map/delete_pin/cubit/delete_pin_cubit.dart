import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/model.dart';
import '../../../../repository/rest_client.dart';
import '../../../../repository/token_interceptor.dart';
import '../../../../util/util.dart';

part 'delete_pin_state.dart';

class DeletePinCubit extends Cubit<DeletePinState> {
  DeletePinCubit() : super(DeletePinInitial());

  Future<void> deletePin(String id) async {
    try {
      emit(DeletePinLoading());

      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<bool> response = await RestClient(dio, baseUrl: endPoint).deletePin(id);

      if (response.success == true) {
        emit(DeletePinLoaded(result: response.data.first));
      } else {
        emit(DeletePinError(errorMessage: response.error ?? 'delete pin error'));
      }
    } catch (e) {
      emit(
        DeletePinError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
