// import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enum/category_type.dart';
import '../model/pin/model_response_pins.dart';
import '../style/du_colors.dart';

BuildContext? globalContext;
bool get isIos => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
E? firstOrNull<E>(List<E>? list) {
  return list == null || list.isEmpty ? null : list.first;
}

extension DateTimeExtension on DateTime {
  String toTimeString() {
    return DateFormat('H:mm:ss:SSS').format(this);
  }

  String toStringWith(String format) {
    return DateFormat(format).format(this);
  }

  String toShortDateString() {
    return DateFormat("yyyy.MM.dd").format(this);
  }

  String toShortString() {
    return DateFormat("yyyy.MM.dd hh:mm a").format(this);
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }
}

Color setPinColor(ModelResponsePins pin) {
  if (pin.category == CategoryType.drink) {
    return DUColors.tomato;
  }
  if (pin.category == CategoryType.eat) {
    return DUColors.azul;
  }
  if (pin.category == CategoryType.meetup) {
    return DUColors.facebook_blue;
  }

  if (pin.category == CategoryType.trade) {
    return DUColors.violet;
  } else {
    return DUColors.brown_grey;
  }
}
