part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState({this.postLocation, this.temporaryLocation});
  final ModelLocation? postLocation;
  final ModelLocation? temporaryLocation;
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  LocationInitial()
      : super(
            postLocation: ModelLocation(), temporaryLocation: ModelLocation());
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  const LocationLoaded(
      {required ModelLocation? postLocation,
      required ModelLocation? temporaryLocation})
      : super(postLocation: postLocation, temporaryLocation: temporaryLocation);

  @override
  List<Object?> get props => [
        postLocation,
        temporaryLocation,
      ];
}

class LocationError extends LocationState {
  final String errorMessage;

  const LocationError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
