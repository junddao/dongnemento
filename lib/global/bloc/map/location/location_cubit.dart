import 'package:base_project/global/enum/cubit_status.dart';
import 'package:base_project/global/enum/cubit_status.dart';
import 'package:base_project/global/model/etc/model_response_kakao_location.dart';
import 'package:base_project/global/model/post/model_response_set_post.dart';
import 'package:base_project/global/repository/map_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<void> setPostLocation(
    LatLng postLocation,
  ) async {
    // emit(LocationLoading());

    LocationState prevState = state;

    ModelLocation newPost = prevState.postLocation!.copyWith(
      lat: postLocation.latitude,
      lng: postLocation.longitude,
    );
    emit(LocationLoading());

    String address = await getKakaoAddressByLocation(
        postLocation.longitude, postLocation.latitude);

    emit(LocationLoaded(
      postLocation: newPost.copyWith(address: address),
      temporaryLocation: prevState.temporaryLocation,
    ));
  }

  Future<void> setTemporaryLocation(
    LatLng temporaryLocation,
  ) async {
    // emit(LocationLoading());

    LocationState prevState = state;

    ModelLocation newTemporaryLocation = prevState.temporaryLocation!.copyWith(
      lat: temporaryLocation.latitude,
      lng: temporaryLocation.longitude,
    );
    emit(LocationLoading());

    String address = await getKakaoAddressByLocation(
        temporaryLocation.longitude, temporaryLocation.latitude);

    emit(LocationLoaded(
      postLocation: prevState.postLocation,
      temporaryLocation: newTemporaryLocation.copyWith(address: address),
    ));
  }

  Future<String> getKakaoAddressByLocation(double lng, double lat) async {
    ModelResponseKakaoLocation modelResponseKakaoLocation =
        await MapRepository.instance.getKakaoAddressByLocation(lng, lat);

    return modelResponseKakaoLocation.documents.first.address_name;
  }

  Future<void> clearPostLocation() async {
    LocationState prevState = state;
    emit(LocationLoading());
    emit(LocationLoaded(
      postLocation: ModelLocation(),
      temporaryLocation: prevState.temporaryLocation,
    ));
  }

  Future<void> clearTemporaryLocation() async {
    LocationState prevState = state;
    emit(LocationLoading());
    emit(LocationLoaded(
      postLocation: prevState.postLocation,
      temporaryLocation: ModelLocation(),
    ));
  }
}
