part of 'get_pins_cubit.dart';

abstract class GetPinsState extends Equatable {
  const GetPinsState();

  @override
  List<Object> get props => [];
}

class GetPinsInitial extends GetPinsState {}

class GetPinsLoading extends GetPinsState {}

class GetPinsLoaded extends GetPinsState {
  final ModelResponseGetPin result;

  const GetPinsLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class GetMarkerLoaded extends GetPinsState {
  final List<Marker> markers;

  const GetMarkerLoaded({required this.markers});
  @override
  List<Object> get props => [markers];
}

class GetPinsError extends GetPinsState {
  final String errorMessage;

  const GetPinsError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
