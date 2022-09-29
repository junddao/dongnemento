import 'package:base_project/global/style/du_colors.dart';
import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  /// 스타일 색상 추가
  ///
  /// #614385
  ///
  /// rgba(97, 67, 133, 1)
  TextStyle get violet => copyWith(color: DUColors.violet);

  /// 스타일 색상 추가
  ///
  /// #87ABD6
  ///
  /// rgba(135, 171, 214, 1)
  TextStyle get subBlue => copyWith(color: DUColors.subBlue);

  /// 스타일 색상 추가
  ///
  /// #E02020
  ///
  /// rgba(224, 32, 32, 1)
  TextStyle get warning => copyWith(color: DUColors.warning);

  /// 스타일 색상 추가
  ///
  /// #FFFFFF
  ///
  /// rgba(255, 255, 255, 1)
  TextStyle get white => copyWith(color: DUColors.white);

  /// 스타일 색상 추가
  ///
  /// #2D2D2D
  ///
  /// rgba(45, 45, 45, 1)
  TextStyle get grey0 => copyWith(color: DUColors.grey0);

  /// 스타일 색상 추가
  ///
  /// #8F8F8F
  ///
  /// rgba(143, 143, 143, 1)
  TextStyle get grey1 => copyWith(color: DUColors.grey1);

  /// 스타일 색상 추가
  ///
  /// #B7B7B7
  ///
  /// rgba(183, 183, 183, 1)
  TextStyle get grey2 => copyWith(color: DUColors.grey2);

  /// 스타일 색상 추가
  ///
  /// #D8D8D8
  ///
  /// rgba(216, 216, 216, 1)
  TextStyle get grey3 => copyWith(color: DUColors.grey3);

  /// 스타일 색상 추가
  ///
  /// #EFEFEF
  ///
  /// rgba(239, 239, 239, 1)
  TextStyle get grey4 => copyWith(color: DUColors.grey4);

  /// 스타일 색상 추가
  ///
  /// #F8F8F8
  ///
  /// rgba(248, 248, 248, 1)
  TextStyle get grey5 => copyWith(color: DUColors.grey5);

  /// 스타일 색상 추가
  ///
  /// #000000
  ///
  /// rgba(0, 0, 0, 1)
  TextStyle get black => copyWith(color: DUColors.black);

  /// #0084FF
  ///
  /// rgba(0, 132, 255, 1)
  TextStyle get link => copyWith(color: DUColors.link);

  /// #907BAA
  ///
  /// rgba(144, 123, 170, 1)
  TextStyle get fabs => copyWith(color: DUColors.fabs);

  /// #469C51
  ///
  /// rgba(70, 156, 81, 1)
  TextStyle get join => copyWith(color: DUColors.join);

  /// #FCE9E9
  ///
  /// rgba(252, 233, 233, 1)
  TextStyle get etc1 => copyWith(color: DUColors.etc1);

  /// #E9F8EF
  ///
  /// rgba(233, 248, 239, 1)
  TextStyle get etc2 => copyWith(color: DUColors.etc2);

  /// #7FDA4A
  ///
  /// rgba(127, 218, 74, 1)
  TextStyle get right => copyWith(color: DUColors.right);

  /// 문자열 높이 조절
  ///
  /// height 1.0
  TextStyle get h1_0 => copyWith(height: 1.0);

  /// 문자열 높이 조절
  ///
  /// height 1.4
  TextStyle get h1_4 => copyWith(height: 1.41667);

  /// 문자열 높이 조절
  ///
  /// height 1.5
  TextStyle get h1_5 => copyWith(height: 1.5);

  /// 문자열 높이 조절
  ///
  /// height 2.0
  TextStyle get h2_0 => copyWith(height: 2.0);

  /// 문자열 높이 조절
  ///
  /// regular
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// 문자열 높이 조절
  ///
  /// medium
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
}
