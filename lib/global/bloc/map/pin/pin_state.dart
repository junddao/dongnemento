part of 'pin_cubit.dart';

abstract class PinState extends Equatable {
  const PinState();

  @override
  List<Object> get props => [];
}

class PinInitial extends PinState {}

class PinLoading extends PinState {}

class PinUpdated extends PinState {
  final bool result;

  const PinUpdated({required this.result});
  @override
  List<Object> get props => [result];
}

class PinLoaded<T> extends PinState {
  final ModelResponsePin result;

  const PinLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class PinError extends PinState {
  final String errorMessage;

  const PinError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
