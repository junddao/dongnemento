import 'dart:io';

import 'package:flutter/material.dart';

class DUTextStyle {
  DUTextStyle._();

  // fontFamail
  static final String? _fontFamily = Platform.isIOS ? "NotoSansKR" : null;
  static final List<String>? _fontFamilyFallback = Platform.isIOS ? ["NotoSansKR"] : null;

  /// Weight : Regular(400)
  ///
  /// Size : 8
  static const size8 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 8,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 8
  static const size8M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 8,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 8
  static const size8B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 8,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 20
  static const size20 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 20
  static const size20M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 20
  static const size20B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 12
  static const size12 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 12
  static const size12M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 12
  static const size12B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 14
  static const size14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 14
  static const size14M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 14
  static const size14B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 16
  static const size16 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 16
  static const size16M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 16
  static const size16B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 18
  static const size18 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 18
  static const size18M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 18
  static const size18B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 10
  static const size10 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 10
  static const size10M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 10
  static const size10B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 10,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 22
  static const size22 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 22,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 22
  static const size22M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 22
  static const size22B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 24
  static const size24 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 24
  static const size24M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 24
  static const size24B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 26
  static const size26 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 26,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 26
  static const size26M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 26,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 26
  static const size26B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 26,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 28
  static const size28 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 28,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 28
  static const size28M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 28,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 28
  static const size28B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 28,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 30
  static const size30 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 30,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 30
  static const size30M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 30
  static const size30B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 32
  static const size32 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 32,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 32
  static const size32M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 32,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 32
  static const size32B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 32,
  );

  /// Weight : Regular(400)
  ///
  /// Size : 32
  static const size40 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 40,
  );

  /// Weight : Medium(500)
  ///
  /// Size : 32
  static const size40M = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 40,
  );

  /// Weight : Bold (700)
  ///
  /// Size : 32
  static const size40B = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 40,
  );
}
