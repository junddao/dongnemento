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

    ModelResponseSetPost newPost = state.modelResponseSetPost!.copyWith(
      lat: postLocation.latitude,
      lng: postLocation.longitude,
    );
    emit(LocationLoading());

    String address = await getKakaoAddressByLocation(
        postLocation.longitude, postLocation.latitude);

    ;

    emit(LocationLoaded(
      modelResponseSetPost: newPost.copyWith(address: address),
      // myLocation:
    ));
  }

  Future<String> getKakaoAddressByLocation(double lng, double lat) async {
    ModelResponseKakaoLocation modelResponseKakaoLocation =
        await MapRepository.instance.getKakaoAddressByLocation(lng, lat);

    return modelResponseKakaoLocation.documents.first.address_name;
  }

  Future<void> clearPostLocation() async {
    emit(LocationLoading());
    emit(LocationLoaded(modelResponseSetPost: ModelResponseSetPost()));
  }
}
