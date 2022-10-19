import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  setLastLocation(
    LatLng? lastLocation,
  ) {
    emit(LocationLoaded(
      lastLocation: lastLocation,
      // myLocation:
    ));
  }

  setPostLocation(LatLng? postLocation) {
    emit(
      LocationLoaded(postLocation: postLocation),
    );
  }

  setPost(LatLng? point) {}

  getMyLocation() {
    LatLng? myLocation = (state as LocationLoaded).myLocation;
    emit(LocationLoaded(myLocation: myLocation));
  }
}
