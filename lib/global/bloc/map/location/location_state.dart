part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState({this.modelResponseSetPost});
  final ModelResponseSetPost? modelResponseSetPost;
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  LocationInitial() : super(modelResponseSetPost: ModelResponseSetPost());
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  const LocationLoaded({required ModelResponseSetPost? modelResponseSetPost})
      : super(modelResponseSetPost: modelResponseSetPost);

  @override
  List<Object?> get props => [modelResponseSetPost];
}

class LocationError extends LocationState {}
