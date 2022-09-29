import 'package:base_project/global/enum/state_enum.dart';
import 'package:base_project/global/model/account/response/me_result.dart';
import 'package:base_project/global/repository/accounts_repository.dart';
import 'package:base_project/global/repository/common/repo_interface.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'me_state.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit() : super(const MeState._());

  Future<void> me() async {
    try {
      emit(const MeState.loading());
      DataOrFailure<MeResult> meResult = await AccountRepository.instance.me();

      if (meResult.isFailed) {
        emit(MeState.failure(message: meResult.failure.msg));
      }

      await SecureStorage.instance.writeMe(meResult.data!.me);
      emit(MeState.success(result: meResult.data));
    } catch (e) {
      emit(MeState.failure(message: e.toString()));
    }
  }
}
