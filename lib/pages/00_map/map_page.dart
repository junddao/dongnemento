import 'dart:async';

import 'package:base_project/global/bloc/map/location/location_cubit.dart';
import 'package:base_project/global/bloc/singleton_me/singleton_me_cubit.dart';
import 'package:base_project/global/enum/cubit_status.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_button.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/date_converter.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:base_project/global/util/range_by_zoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return const MapPageView();
  }
}

class MapPageView extends StatefulWidget {
  const MapPageView({super.key});

  @override
  State<MapPageView> createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPageView> {
  final List<Marker> _markers = [];
  final List<Marker> _temporaryMaker = [];
  late final LatLng _lastLocation;

  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController mapController;

  int? range = 1000;

  BitmapDescriptor? customIcon;

  @override
  void initState() {
    double lat = context.read<SingletonMeCubit>().me.lat ?? 0;
    double lng = context.read<SingletonMeCubit>().me.lng ?? 0;
    _lastLocation = LatLng(lat, lng);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(),
      body: SafeArea(
        top: true,
        child: _body(),
      ),
    );
  }

  Widget _floatingActionButton() {
    double? lat = context.read<SingletonMeCubit>().me.lat;
    double? lng = context.read<SingletonMeCubit>().me.lng;
    LatLng myLocation = LatLng(lat ?? 0, lng ?? 0);
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: FloatingActionButton(
        mini: true,
        child: const Icon(Icons.my_location_outlined),
        onPressed: () {
          moveCameraToMyLocation(myLocation);
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoaded) {
          print('state loaded');
        }
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) async {
                await _onMapCreated(controller, _lastLocation);
              },
              initialCameraPosition: CameraPosition(
                target: _lastLocation,
                zoom: 15,
              ),

              markers: <Marker>{..._markers, ..._temporaryMaker},
              rotateGesturesEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,

              // padding: const EdgeInsets.only(bottom: 130, right: 0),
              // mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              onCameraMove: _onCameraMove,
              // onCameraIdle: _onCameraIdle,

              onTap: (point) {
                _handleTap(point);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _onMapCreated(
      GoogleMapController controller, LatLng location) async {
    _markers.clear();
    _controller.complete(controller);
  }

  void moveCameraToMyLocation(LatLng? myLocation) {
    _controller.future.then((value) {
      value.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(myLocation?.latitude ?? 0, myLocation?.longitude ?? 0),
          zoom: 15,
        ),
      ));
    });
  }

  // void moveCameraToLastLocation() {

  //   _controller.future.then((value) {
  //     value.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         bearing: 0,
  //         target: LatLng(provider.lastLocation!.latitude,
  //             provider.lastLocation!.longitude),
  //         zoom: 15,
  //       ),
  //     ));
  //   });
  // }

  void _onCameraMove(CameraPosition position) {
    // context.read<LocationCubit>().setLastLocation(position.target);
    // print("move");
    print(position.zoom.toString());
    range = RangeByZoom.getRangeByZoom(position.zoom);
  }

  _handleTap(LatLng point) {
    double lat = DataConvert.roundDouble(point.latitude, 6);
    double lng = DataConvert.roundDouble(point.longitude, 6);
    LatLng location = LatLng(lat, lng);

    print('handelTap');
    context.read<LocationCubit>().setPostLocation(location);

    // locationProvider.setPost(point);

    // 글을 남길 위치에 임시 마커를 박는다.
    _temporaryMaker.clear();
    addTemporaryMarker(0, location);

    showModalBottomSheet(
      context: GoRouter.of(context).navigator!.context,
      // isScrollControlled: true,
      builder: (_) {
        return buildSelectLocationBottomSheet(context);
      },
    ).then((value) {
      if (value != true) {
        // 취소하면 postLocation 초기화 필요.
        context.read<LocationCubit>().clearPostLocation();
      }
      _temporaryMaker.clear();
    });
  }

  Widget buildSelectLocationBottomSheet(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: DUColors.white),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.modelResponseSetPost?.address ?? '',
                    style: DUTextStyle.size14M.black),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                DUButton(
                  text: '여기에 새글을 쓰겠어요!',
                  width: SizeConfig.screenWidth,
                  press: () {
                    // context.pop();
                    Navigator.pop(context);
                    context.go('/map/post');
                  },
                ),
                DUButton(
                  text: '다음에 쓸께요.',
                  width: SizeConfig.screenWidth,
                  type: ButtonType.transparent,
                  press: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addTemporaryMarker(int id, LatLng latLng) {
    final marker = Marker(
      markerId: MarkerId(id.toString()),
      position: latLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      // icon: customIcon!,
    );
    _temporaryMaker.add(marker);
  }
}
