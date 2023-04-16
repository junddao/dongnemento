import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../env.dart';
import '../../../model/model.dart';
import '../../../repository/rest_client.dart';
import '../../../repository/token_interceptor.dart';

part 'block_user_state.dart';

class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserCubit() : super(BlockUserInitial());

  Future<void> blockUser(ModelRequestBlock modelRequestBlock) async {
    try {
      emit(BlockUserLoading());
      final dio = Dio(); // Provide a dio instance
      dio.interceptors.add(TokenInterceptor(RestClient(dio)));
      DataResponse<ModelUser> response = await RestClient(dio, baseUrl: Env.apiBaseUrl).blockUser(modelRequestBlock);

      if (response.success == false) {
        emit(BlockUserError(errorMessage: response.error ?? 'report error'));
      } else {
        emit(BlockUserLoaded(user: response.data.first));
      }
    } catch (e) {
      emit(BlockUserError(
        errorMessage: e.toString(),
      ));
    }
  }
}
