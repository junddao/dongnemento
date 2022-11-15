part of 'set_pin_like_cubit.dart';

abstract class SetPinLikeState extends Equatable {
  const SetPinLikeState();

  @override
  List<Object> get props => [];
}

class SetPinLikeInitial extends SetPinLikeState {}

class SetPinLikeLoading extends SetPinLikeState {}

class SetPinLikeLoaded extends SetPinLikeState {
  final bool result;

  const SetPinLikeLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class SetPinLikeError extends SetPinLikeState {
  final String errorMessage;

  const SetPinLikeError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
