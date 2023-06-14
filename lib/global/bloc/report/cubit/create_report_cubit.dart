import 'package:base_project/global/repository/rest_api_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';

part 'create_report_state.dart';

class CreateReportCubit extends Cubit<CreateReportState> {
  CreateReportCubit() : super(CreateReportInitial());

  Future<void> createReport(ModelRequestReport modelRequestReport) async {
    try {
      emit(CreateReportLoading());

      DataResponse<bool> response = await RestApiManager.instance.getRestClient().createReport(modelRequestReport);

      if (response.success == true) {
        emit(CreateReportLoaded(result: response.data.first));
      } else {
        emit(CreateReportError(errorMessage: response.error ?? 'report error'));
      }
    } catch (e) {
      emit(CreateReportError(
        errorMessage: e.toString(),
      ));
    }
  }
}
