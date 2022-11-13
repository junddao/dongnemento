part of 'create_pin_reply_cubit.dart';

abstract class CreatePinReplyState extends Equatable {
  const CreatePinReplyState();

  @override
  List<Object> get props => [];
}

class CreatePinReplyInitial extends CreatePinReplyState {}

class CreatePinReplyLoading extends CreatePinReplyState {}

class CreatePinReplyLoaded extends CreatePinReplyState {
  final bool result;

  const CreatePinReplyLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class CreatePinReplyError extends CreatePinReplyState {
  final String errorMessage;

  const CreatePinReplyError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
