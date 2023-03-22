import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/common/api_response.dart';
import '../../../../repository/pin_repository.dart';

part 'delete_pin_state.dart';

class DeletePinCubit extends Cubit<DeletePinState> {
  DeletePinCubit() : super(DeletePinInitial());

  Future<void> deletePin(String id) async {
    try {
      emit(DeletePinLoading());

      ApiResponse<bool> response = await PinRepository.instance.deletePin(id);
      if (response.status == ResponseStatus.error) {
        emit(
          DeletePinError(errorMessage: response.message ?? 'create pin error'),
        );
      } else {
        emit(DeletePinLoaded(result: response.data!));
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
