part of 'create_pin_cubit.dart';

abstract class CreatePinState extends Equatable {
  const CreatePinState();

  @override
  List<Object> get props => [];
}

class CreatePinInitial extends CreatePinState {}

class CreatePinLoading extends CreatePinState {}

class CreatePinLoaded extends CreatePinState {
  final bool result;

  const CreatePinLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class CreatePinError extends CreatePinState {
  final String errorMessage;

  const CreatePinError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
