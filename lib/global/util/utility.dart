// import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import '../enum/category_type.dart';
import '../model/pin/model_response_pins.dart';
import '../style/du_colors.dart';

BuildContext? globalContext;
bool get isIos => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;
E? firstOrNull<E>(List<E>? list) {
  return list == null || list.isEmpty ? null : list.first;
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }
}

Color setPinColor(ModelResponsePins pin) {
  if (pin.category == CategoryType.mart) {
    return DUColors.tomato;
  }
  if (pin.category == CategoryType.daily) {
    return DUColors.azul;
  }
  if (pin.category == CategoryType.cafe || pin.category == CategoryType.restaurant) {
    return DUColors.facebook_blue;
  }

  if (pin.category == CategoryType.hairShop) {
    return DUColors.violet;
  } else {
    return DUColors.brownish_grey;
  }
}

/// api주소
String get endPoint => FlavorConfig.instance.variables['EndPoint'];
