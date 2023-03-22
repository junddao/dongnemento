part of 'get_user_cubit.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserLoaded extends GetUserState {
  final ModelUser user;

  const GetUserLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class GetUserError extends GetUserState {
  final String errorMessage;

  const GetUserError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
