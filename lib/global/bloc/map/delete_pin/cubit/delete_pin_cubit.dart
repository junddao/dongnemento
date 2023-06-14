import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/model.dart';

part 'delete_pin_state.dart';

class DeletePinCubit extends Cubit<DeletePinState> {
  DeletePinCubit() : super(DeletePinInitial());

  Future<void> deletePin(String id) async {
    try {
      emit(DeletePinLoading());

      DataResponse<bool> response = await RestApiManager.instance.getRestClient().deletePin(id);

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
