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

  void copyWithSingletonMe(ModelUser me) {
    emit(SingletonMeLoading());
    _me = me.copyWith(
      address: me.address,
      createdAt: me.createdAt,
      email: me.email,
      id: me.id,
      name: me.name,
      introduce: me.introduce,
      updatedAt: me.updatedAt,
      isBlocked: me.isBlocked,
      lat: me.lat,
      lng: me.lng,
      password: me.password,
      profileImage: me.address,
      pushEnabled: me.pushEnabled,
      social: me.social,
    );
    emit(SingletonMeLoaded(singletonMe: me));
  }
}
