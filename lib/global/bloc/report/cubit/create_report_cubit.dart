import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';
import '../../../util/util.dart';

part 'create_report_state.dart';

class CreateReportCubit extends Cubit<CreateReportState> {
  CreateReportCubit() : super(CreateReportInitial());

  Future<void> createReport(ModelRequestReport modelRequestReport) async {
    try {
      emit(CreateReportLoading());

      final dio = Dio();
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<bool> response = await RestClient(dio, baseUrl: endPoint).createReport(modelRequestReport);

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
