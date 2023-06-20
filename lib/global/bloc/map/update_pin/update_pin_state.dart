part of 'update_pin_cubit.dart';

abstract class UpdatePinState extends Equatable {
  const UpdatePinState();

  @override
  List<Object> get props => [];
}

class UpdatePinInitial extends UpdatePinState {}

class UpdatePinLoading extends UpdatePinState {}

class UpdatePinLoaded extends UpdatePinState {
  final bool result;

  const UpdatePinLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class UpdatePinError extends UpdatePinState {
  final String errorMessage;

  const UpdatePinError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
