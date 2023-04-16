import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../env.dart';
import '../../../../model/model.dart';
import '../../../../repository/rest_client.dart';
import '../../../../repository/token_interceptor.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());

  Future<void> getUser(String id) async {
    try {
      emit(GetUserLoading());
      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<ModelUser> response = await RestClient(dio, baseUrl: Env.apiBaseUrl).getUser(id);

      if (response.success == false) {
        emit(GetUserError(errorMessage: response.error ?? 'report error'));
      } else {
        emit(GetUserLoaded(user: response.data.first));
      }
    } catch (e) {
      emit(GetUserError(
        errorMessage: e.toString(),
      ));
    }
  }
}
