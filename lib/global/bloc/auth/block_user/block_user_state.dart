part of 'block_user_cubit.dart';

abstract class BlockUserState extends Equatable {
  const BlockUserState();

  @override
  List<Object> get props => [];
}

class BlockUserInitial extends BlockUserState {}

class BlockUserLoading extends BlockUserState {}

class BlockUserLoaded extends BlockUserState {
  final ModelUser user;

  const BlockUserLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class BlockUserError extends BlockUserState {
  final String errorMessage;

  const BlockUserError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
