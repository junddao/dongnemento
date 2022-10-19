part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LatLng? lastLocation;
  final LatLng? myLocation;
  final LatLng? postLocation;

  const LocationLoaded(
      {this.lastLocation,
      this.myLocation = const LatLng(37.2, 127.0),
      this.postLocation});

  @override
  List<Object?> get props => [lastLocation, myLocation, postLocation];
}

class LocationError extends LocationState {}
