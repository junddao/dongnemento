import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:base_project/global/bloc/auth/get_me/me_cubit.dart';
import 'package:base_project/global/bloc/map/get_pins/get_pins_cubit.dart';
import 'package:base_project/global/bloc/map/location/location_cubit.dart';
import 'package:base_project/global/model/pin/model_request_get_pin.dart';
import 'package:base_project/global/model/pin/model_response_get_pin.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_button.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/date_converter.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:base_project/global/util/range_by_zoom.dart';
import 'package:base_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as path;

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
  List<Marker> _pinMarkers = [];
  List<ResponsePin> pins = [];
  final List<Marker> _temporaryMaker = [];
  late LatLng _lastLocation;
  int? range = 3000;

  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController mapController;

  BitmapDescriptor? customIcon;

  @override
  void initState() {
    double lat = context.read<MeCubit>().me.lat ?? 0;
    double lng = context.read<MeCubit>().me.lng ?? 0;
    _lastLocation = LatLng(lat, lng);

    ModelRequestGetPin modelRequestGetPin = ModelRequestGetPin(
      lat: lat,
      lng: lng,
      range: range,
    );
    context.read<GetPinsCubit>().getPins(modelRequestGetPin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      floatingActionButton: _floatingActionButton(),
      body: _body(),
    );
  }

  Widget _floatingActionButton() {
    double? lat = context.read<MeCubit>().me.lat;
    double? lng = context.read<MeCubit>().me.lng;
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
      builder: (context, locationState) {
        if (locationState is LocationLoaded) {
          print('state loaded');
        }

        return BlocBuilder<GetPinsCubit, GetPinsState>(
          builder: (context, getPinsState) {
            if (getPinsState is GetPinsLoaded) {
              pins = getPinsState.result.data ?? [];
              // _pinMarkers = getPinsState.markers;
              // _drawPin(pins);
            }
            return FutureBuilder(
                future: _drawPin(pins),
                builder: (context, snapshot) {
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
                        markers: <Marker>{..._pinMarkers, ..._temporaryMaker},
                        rotateGesturesEnabled: false,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        onCameraMove: _onCameraMove,
                        onCameraIdle: _onCameraIdle,
                        onTap: (point) {
                          _handleTap(point);
                        },
                      ),
                    ],
                  );
                });
          },
        );
      },
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller, LatLng location) async {
    _pinMarkers.clear();
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

  void _onCameraMove(CameraPosition position) {
    print(position.zoom.toString());
    range = RangeByZoom.getRangeByZoom(position.zoom);
    _lastLocation = LatLng(position.target.latitude, position.target.longitude);
  }

  _handleTap(LatLng point) {
    double lat = DataConvert.roundDouble(point.latitude, 6);
    double lng = DataConvert.roundDouble(point.longitude, 6);
    LatLng location = LatLng(lat, lng);

    print('handelTap');

    // 글을 남길 위치에 임시 마커를 박는다.
    _temporaryMaker.clear();
    addTemporaryMarker(0, location);
    context.read<LocationCubit>().setTemporaryLocation(location);

    showModalBottomSheet(
      context: rootNavigatorKey.currentContext!,
      builder: (_) {
        return buildSelectLocationBottomSheet(context, location);
      },
    ).then((value) {
      removeTemporaryMarker();
      context.read<LocationCubit>().clearTemporaryLocation();
    });
  }

  void _onCameraIdle() async {
    ModelRequestGetPin modelRequestGetPin = ModelRequestGetPin(
      lat: _lastLocation.latitude,
      lng: _lastLocation.longitude,
      range: range,
    );
    context.read<GetPinsCubit>().getPins(modelRequestGetPin);
  }

  Future<void> addPinMarker(List<ResponsePin> pins) async {
    for (var pin in pins) {
      customIcon = await createCustomMarkerBitmap(pin.title!);
      final marker = Marker(
          markerId: MarkerId(pin.id!),
          position: LatLng(pin.lat ?? 0, pin.lng ?? 0),
          icon: customIcon!,
          onTap: () {
            print('marker onTap()');
            // 상세 핀 페이지로 이동
            // context.go('/map/${pin.id}');
          });
      _pinMarkers.add(marker);
    }
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(String title) async {
    // final Size size = Size(150, 150);
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint tagPaint = Paint()..color = DUColors.tomato;

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
        text: title.length < 22 ? title : '${title.substring(0, 10)}\n${title.substring(10, 20)}..',
        style: DUTextStyle.size30B.white);

    textPainter.layout();

    // add shape
    Size size = Size(textPainter.width + 40, textPainter.height + 20);
    final bubbleSize = Size(size.width, size.height);
    final tailSize = Size(20, bubbleSize.height);

    const radius = 20.0;
    final tailStartPoint = Point(size.width * 0.5 - 10, bubbleSize.height);
    //bubble body
    final bubblePath = Path()
      ..moveTo(0, radius)
      // 왼쪽 위에서 왼쪽 아래 라인
      ..lineTo(0, bubbleSize.height - radius)
      ..arcToPoint(
        Offset(radius, bubbleSize.height),
        radius: const Radius.circular(radius),
        clockwise: false,
      )
      // 왼쪽 아래에서 오른쪽 아래 라인
      ..lineTo(bubbleSize.width - radius, bubbleSize.height)
      ..arcToPoint(
        Offset(bubbleSize.width, bubbleSize.height - radius),
        radius: const Radius.circular(radius),
        clockwise: false,
      )

      // 오른쪽 아래에서 오른쪽 위 라인
      ..lineTo(bubbleSize.width, radius)
      ..arcToPoint(
        Offset(bubbleSize.width - radius, 0),
        radius: const Radius.circular(radius),
        clockwise: false,
      )

      // 오른쪽 위에서 왼쪽 아래 라인
      ..lineTo(radius, 0)
      ..arcToPoint(
        const Offset(0, radius),
        radius: const Radius.circular(radius),
        clockwise: false,
      );

    // bubble tail

    var points = [
      Offset(tailStartPoint.x, tailStartPoint.y),
      Offset(tailStartPoint.x + 10, tailStartPoint.y + 10),
      Offset(tailStartPoint.x + 15, tailStartPoint.y + 10),
      Offset(tailStartPoint.x + 20, tailStartPoint.y),
    ];

    final tailPath = Path()
      ..moveTo(tailStartPoint.x, tailStartPoint.y)
      ..addPolygon(points, false)
      ..close();

    // final tailPath = Path()
    //   ..cubicTo(
    //     tailStartPoint.x + (tailSize.width * 0.4),
    //     tailStartPoint.y,
    //     tailStartPoint.x + (tailSize.width * 0.6),
    //     tailStartPoint.y + (tailSize.height * 0.2),
    //     tailStartPoint.x + tailSize.width / 2, // 목적지 x
    //     tailStartPoint.y + tailSize.height, // 목적지 y
    //   )
    //   ..cubicTo(
    //     (tailStartPoint.x + tailSize.width / 2) + (tailSize.width * 0.2),
    //     tailStartPoint.y + tailSize.height,
    //     tailStartPoint.x + tailSize.width,
    //     tailStartPoint.y + (tailSize.height * 0.3),
    //     tailStartPoint.x + tailSize.width, // 목적지 x
    //     tailStartPoint.y, // 목적지 y
    //   );

    bubblePath.addPath(tailPath, Offset(0, 0));

    canvas.drawPath(bubblePath, tagPaint);

    textPainter.paint(canvas, const Offset(20, 10));

    // Convert canvas to image
    final ui.Image markerAsImage =
        await pictureRecorder.endRecording().toImage(textPainter.width.toInt() + 80, textPainter.height.toInt() + 40);

    // Convert image to bytes
    final ByteData? byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Widget buildSelectLocationBottomSheet(BuildContext context, LatLng location) {
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
                Text(state.temporaryLocation?.address ?? '', style: DUTextStyle.size14M.black),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                DUButton(
                  text: '여기에 새글을 쓰겠어요!',
                  width: SizeConfig.screenWidth,
                  press: () {
                    // context.pop();
                    context.read<LocationCubit>().setPostLocation(location).then((value) {
                      Navigator.pop(context, true);
                      context.go(path.join(Routes.map, Routes.post));
                    });
                  },
                ),
                DUButton(
                  text: '다음에 쓸께요.',
                  width: SizeConfig.screenWidth,
                  type: ButtonType.transparent,
                  press: () {
                    Navigator.of(context).pop(false);
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

  void removeTemporaryMarker() {
    _temporaryMaker.clear();
  }

  void onTapMarker(String pinId, String userId) {
    // 상세 핀 페이지로 이동
    context.go('/map/post/$pinId/$userId');
  }

  // BitmapDescriptor? customIcon;

  _drawPin(List<ResponsePin> pins) async {
    List<Marker> markers = [];
    for (var pin in pins) {
      BitmapDescriptor? customIcon = await createCustomMarkerBitmap(pin.title!);
      final marker = Marker(
          markerId: MarkerId(pin.id ?? DateTime.now().toString()),
          position: LatLng(pin.lat ?? 0, pin.lng ?? 0),
          icon: customIcon,
          onTap: () {
            onTapMarker(pin.id!, pin.userId!);
          });
      markers.add(marker);
    }
    _pinMarkers = markers;
  }
}
