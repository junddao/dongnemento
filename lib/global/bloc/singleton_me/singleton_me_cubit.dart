import 'package:base_project/global/model/user/model_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'singleton_me_state.dart';

class SingletonMeCubit extends Cubit<SingletonMeState> {
  SingletonMeCubit() : super(SingletonMeInitial());

  ModelUser _me = ModelUser();

  ModelUser get me => _me;

  void updateSingletonMe(ModelUser me) {
    emit(SingletonMeLoading());
    _me = me;
    emit(SingletonMeLoaded(singletonMe: me));
  }
}
