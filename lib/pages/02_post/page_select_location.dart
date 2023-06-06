import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../global/bloc/map/location/location_cubit.dart';
import '../../global/style/constants.dart';
import '../../global/style/du_button.dart';
import '../../global/style/du_colors.dart';
import '../../global/style/du_text_styles.dart';

class PageSelectLocation extends StatefulWidget {
  const PageSelectLocation({Key? key, required this.location}) : super(key: key);

  final LatLng location;

  @override
  State<PageSelectLocation> createState() => _PageSelectLocationState();
}

class _PageSelectLocationState extends State<PageSelectLocation> {
  final List<Marker> _markers = [];
  final Completer<GoogleMapController> _controller = Completer();

  final TextEditingController _tecAddress = TextEditingController();

  @override
  @override
  void initState() {
    addMarker(0, widget.location);
    super.initState();
  }

  @override
  void dispose() {
    _tecAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('위치 선택'),
      centerTitle: true,
    );
  }

  _body() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Stack(
          children: [
            GoogleMap(
                onMapCreated: (controller) async {
                  await _onMapCreated(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: widget.location,
                  zoom: 15,
                ),
                markers: _markers.toSet(),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                onTap: (point) {
                  _handleTap(point);
                }),
          ],
        );
      },
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();

    _controller.complete(controller);
  }

  void addMarker(int id, LatLng latLng) {
    final marker = Marker(
      markerId: MarkerId(id.toString()),
      position: latLng,
      // icon: customIcon!,
    );
    _markers.add(marker);
  }

  _handleTap(LatLng point) {
    _markers.clear();
    addMarker(0, point);
    context.read<LocationCubit>().setTemporaryLocation(point);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return buildBottomSheet(context, point);
      },
    ).then((value) {
      if (value) context.pop();
    });
  }

  Widget buildBottomSheet(BuildContext context, LatLng point) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: DUColors.white),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.temporaryLocation?.address ?? '', style: DUTextStyle.size14B),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                DUButton(
                  text: '네, 이 위치로 선택할래요!',
                  width: SizeConfig.screenWidth,
                  press: () {
                    context.read<LocationCubit>().setPostLocation(point);

                    context.pop(true);

                    // Navigator.of(context).popUntil(ModalRoute.withName('PagePostCreate'));
                  },
                ),
                DUButton(
                  text: '다시 선택할께요.',
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
}
