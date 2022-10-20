part of 'update_user_cubit.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserLoaded extends UpdateUserState {
  @override
  List<Object> get props => [];
}

class UpdateUserError extends UpdateUserState {
  final String errorMessage;

  const UpdateUserError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
