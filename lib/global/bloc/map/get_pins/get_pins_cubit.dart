import 'dart:math';

import 'package:base_project/global/model/common/api_response.dart';
import 'package:base_project/global/model/pin/model_request_get_pin.dart';
import 'package:base_project/global/model/pin/model_response_get_pin.dart';
import 'package:base_project/global/repository/map_repository.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;

part 'get_pins_state.dart';

class GetPinsCubit extends Cubit<GetPinsState> {
  GetPinsCubit() : super(GetPinsInitial());

  Future<void> getPinWithMarkers(ModelRequestGetPin modelRequestGetPin) async {
    BitmapDescriptor? customIcon;
    final List<Marker> pinMarker = [];
    try {
      emit(GetPinsLoading());

      ApiResponse<ModelResponseGetPin> response =
          await MapRepository.instance.getPins(modelRequestGetPin);

      ModelResponseGetPin modelResponseGetPin = response.data!;
      List<ResponsePin> pins = modelResponseGetPin.data ?? [];
      for (var pin in pins) {
        customIcon = await createCustomMarkerBitmap(pin.title!);
        final marker = Marker(
          markerId: MarkerId(pin.id ?? DateTime.now().toString()),
          position: LatLng(pin.lat ?? 0, pin.lng ?? 0),
          icon: customIcon,
        );
        pinMarker.add(marker);
      }

      if (response.status == ResponseStatus.error) {
        emit(
          GetPinsError(errorMessage: response.message ?? 'get pin error'),
        );
      } else {
        emit(GetMarkerLoaded(markers: pinMarker));
      }
    } catch (e) {
      emit(
        GetPinsError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> getPins(ModelRequestGetPin modelRequestGetPin) async {
    BitmapDescriptor? customIcon;
    try {
      emit(GetPinsLoading());

      ApiResponse<ModelResponseGetPin> response =
          await MapRepository.instance.getPins(modelRequestGetPin);

      if (response.status == ResponseStatus.error) {
        emit(
          GetPinsError(errorMessage: response.message ?? 'get pin error'),
        );
      } else {
        emit(GetPinsLoaded(result: response.data!));
      }
    } catch (e) {
      emit(
        GetPinsError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(String title) async {
    // final Size size = Size(150, 150);
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(70);

    final Paint tagPaint = Paint()..color = DUColors.tomato;

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
        text: title.length < 18 ? title : title.substring(0, 16) + '..',
        style: DUTextStyle.size40B.white);

    textPainter.layout();

    // add shape
    Size size = Size(textPainter.width + 40, textPainter.height + 40);
    final bubbleSize = Size(size.width, size.height * 0.8);
    final tailSize = Size(20, size.height - bubbleSize.height);
    final fillet = bubbleSize.width * 0.1;
    final tailStartPoint = Point(size.width * 0.4, bubbleSize.height);
    //bubble body
    final bubblePath = Path()
      ..moveTo(0, fillet)
      // 왼쪽 위에서 왼쪽 아래 라인
      ..lineTo(0, bubbleSize.height - fillet)
      ..quadraticBezierTo(0, bubbleSize.height, fillet, bubbleSize.height)
      // 왼쪽 아래에서 오른쪽 아래 라인
      ..lineTo(bubbleSize.width - fillet, bubbleSize.height)
      ..quadraticBezierTo(bubbleSize.width, bubbleSize.height, bubbleSize.width,
          bubbleSize.height - fillet)
      // 오른쪽 아래에서 오른쪽 위 라인
      ..lineTo(bubbleSize.width, fillet)
      ..quadraticBezierTo(bubbleSize.width, 0, bubbleSize.width - fillet, 0)
      // 오른쪽 위에서 왼쪽 아래 라인
      ..lineTo(fillet, 0)
      ..quadraticBezierTo(0, 0, 0, fillet);
    // bubble tail
    final tailPath = Path()
      ..moveTo(tailStartPoint.x, tailStartPoint.y)
      ..cubicTo(
        tailStartPoint.x + (tailSize.width * 0.4),
        tailStartPoint.y,
        tailStartPoint.x + (tailSize.width * 0.6),
        tailStartPoint.y + (tailSize.height * 0.2),
        tailStartPoint.x + tailSize.width / 2, // 목적지 x
        tailStartPoint.y + tailSize.height, // 목적지 y
      )
      ..cubicTo(
        (tailStartPoint.x + tailSize.width / 2) + (tailSize.width * 0.2),
        tailStartPoint.y + tailSize.height,
        tailStartPoint.x + tailSize.width,
        tailStartPoint.y + (tailSize.height * 0.3),
        tailStartPoint.x + tailSize.width, // 목적지 x
        tailStartPoint.y, // 목적지 y
      );

    bubblePath.addPath(tailPath, Offset(0, 0));

    canvas.drawPath(bubblePath, tagPaint);

    // // Add tag circle
    // canvas.drawRRect(
    //     RRect.fromRectAndCorners(
    //       Rect.fromLTWH(
    //           0.0, 0.0, textPainter.width + 40, textPainter.height + 20),
    //       topLeft: radius,
    //       topRight: radius,
    //       bottomLeft: radius,
    //       bottomRight: radius,
    //     ),
    //     tagPaint);

    textPainter.paint(canvas, Offset(20, 10));

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
        textPainter.width.toInt() + 80, textPainter.height.toInt() + 40);

    // Convert image to bytes
    final ByteData? byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }
}
