import 'dart:io';

import 'package:flutter/material.dart';

class DUTextStyle {
  DUTextStyle._();

  // fontFamail
  static final String? _fontFamily = Platform.isIOS ? "NotoSansKR" : null;
  static final List<String>? _fontFamilyFallback =
      Platform.isIOS ? ["NotoSansKR"] : null;

  // Regular(Weight:w400)

  /// Weight : Regular(400)
  ///
  /// Size : 30
  static final size30 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 30,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 24
  static final size24 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 20
  static final size20 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 16
  static final size18 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );

  /// Weight : Regular(700)
  ///
  /// Size : 16
  static final size18B = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 16
  static final size16 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 14
  static final size14 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 12
  static final size12 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 10
  static final size10 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 9.3333333
  /// 타이틀에는 1.5배 크게 나오므로 14pt * 2 / 3 = 9.3333333
  static final size9 = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w400,
    fontSize: 9.3333333,
  );

  // Medium(Weight:w500)

  /// Weight : Medium(500)
  ///
  /// Size : 30
  static final size30M = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w500,
    fontSize: 30,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 24
  static final size24M = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 20
  static final size20M = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 16
  static final size16M = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 14
  static final size14M = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 12
  static final size12M = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 10
  static final size10M = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );

  // Bold

  /// Weight : Bold
  ///
  /// Size : 30
  static final size30B = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  /// Weight : Bold
  ///
  /// Size : 24
  static final size24B = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  /// Weight : Bold
  ///
  /// Size : 20
  static final size20B = TextStyle(
    fontFamily: _fontFamily,
    fontFamilyFallback: _fontFamilyFallback,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
}
