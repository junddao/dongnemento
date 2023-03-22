part of 'delete_pin_cubit.dart';

abstract class DeletePinState extends Equatable {
  const DeletePinState();

  @override
  List<Object> get props => [];
}

class DeletePinInitial extends DeletePinState {}

class DeletePinLoading extends DeletePinState {}

class DeletePinLoaded extends DeletePinState {
  final bool result;

  const DeletePinLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class DeletePinError extends DeletePinState {
  final String errorMessage;

  const DeletePinError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
