part of 'get_pin_cubit.dart';

abstract class GetPinState extends Equatable {
  const GetPinState();

  @override
  List<Object> get props => [];
}

class GetPinInitial extends GetPinState {}

class GetPinLoading extends GetPinState {}

class GetPinUpdated extends GetPinState {
  final ModelResponsePin result;

  const GetPinUpdated({required this.result});
  @override
  List<Object> get props => [result];
}

class GetPinLoaded extends GetPinState {
  final ModelResponsePin result;

  const GetPinLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class GetPinError extends GetPinState {
  final String errorMessage;

  const GetPinError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
