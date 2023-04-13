import 'package:base_project/env.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';

part 'get_pin_replies_state.dart';

class GetPinRepliesCubit extends Cubit<GetPinRepliesState> {
  GetPinRepliesCubit() : super(GetPinRepliesInitial());

  Future<void> getPinReplies(String pinId) async {
    try {
      emit(GetPinRepliesLoading());

      final dio = Dio();
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<ModelResponsePinReply> response =
          await RestClient(dio, baseUrl: Env.apiBaseUrl).getPinReplies(pinId);

      if (response.success == true) {
        emit(GetPinRepliesLoaded(result: response.data));
      } else {
        emit(GetPinRepliesError(errorMessage: response.error ?? 'get pin replies error'));
      }
    } catch (e) {
      emit(
        GetPinRepliesError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
