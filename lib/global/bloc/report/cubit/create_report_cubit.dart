import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/report/model_request_report.dart';
import 'package:base_project/global/repository/report_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_report_state.dart';

class CreateReportCubit extends Cubit<CreateReportState> {
  CreateReportCubit() : super(CreateReportInitial());

  Future<void> createReport(ModelRequestReport modelRequestReport) async {
    try {
      emit(CreateReportLoading());

      ApiResponse<bool> response = await ReportRepository.instance.createReport(modelRequestReport);

      if (response.status == ResponseStatus.error) {
        emit(CreateReportError(errorMessage: response.message ?? 'report error'));
      } else {
        emit(CreateReportLoaded(result: response.data!));
      }
    } catch (e) {
      emit(CreateReportError(
        errorMessage: e.toString(),
      ));
    }
  }
}
