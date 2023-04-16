part of 'get_my_pins_cubit.dart';

abstract class GetMyPinsState extends Equatable {
  const GetMyPinsState();

  @override
  List<Object> get props => [];
}

class GetMyPinsInitial extends GetMyPinsState {}

class GetMyPinsLoading extends GetMyPinsState {}

class GetMyPinsLoaded extends GetMyPinsState {
  final List<ModelResponsePins> result;

  const GetMyPinsLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class GetMyPinsError extends GetMyPinsState {
  final String errorMessage;

  const GetMyPinsError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
