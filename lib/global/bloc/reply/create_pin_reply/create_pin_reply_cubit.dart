import 'package:base_project/env.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';

part 'create_pin_reply_state.dart';

class CreatePinReplyCubit extends Cubit<CreatePinReplyState> {
  CreatePinReplyCubit() : super(CreatePinReplyInitial());

  Future<void> createPinReply(ModelRequestCreatePinReply requestCreatePinReply) async {
    try {
      emit(CreatePinReplyLoading());

      final dio = Dio();
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<bool> response =
          await RestClient(dio, baseUrl: Env.apiBaseUrl).createPinReply(requestCreatePinReply);

      if (response.success == true) {
        emit(CreatePinReplyLoaded(result: response.data.first));
      } else {
        emit(CreatePinReplyError(errorMessage: response.error ?? 'create pin reply error'));
      }
    } catch (e) {
      emit(
        CreatePinReplyError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
