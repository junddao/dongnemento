import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonType {
  const ButtonType._(this.type);

  final String type;
  static const normal = ButtonType._('normal');

  static const dark = ButtonType._('dark');
  static const success = ButtonType._('success');
  static const warning = ButtonType._('warning');
  static const disabled = ButtonType._('disabled');
  static const transparent = ButtonType._('transparent');
  static const normal_black = ButtonType._('normal_black');
  static const normal_tomato = ButtonType._('normal_tomato');
  static const decline = ButtonType._('decline');

  @override
  String toString() {
    return const <String, String>{
      'normal': 'ButtonType.normal',
      'dark': 'ButtonType.dark',
      'transparent': 'ButtonType.transparent',
      'success': 'ButtonType.success',
      'warning': 'ButtonType.warning',
      'disabled': 'ButtonType.disabled',
      'normal_black': 'ButtonType.normal_black',
      'normal_tomato': 'ButtonType.normal_tomato',
      'decline': 'ButtonType.decline'
    }[type]!;
  }

  Color? buttonColor() {
    return const <String, Color>{
      'normal': DUColors.tomato,
      'normal_blue02': DUColors.blue02,
      'normal_blue04': Colors.transparent,
      'dark': DUColors.purple_red,
      'transparent': Colors.transparent,
      'success': DUColors.tomato,
      'warning': DUColors.tomato,
      'disabled': DUColors.grey2,
      'normal_black': DUColors.black,
      'decline': DUColors.decline,
    }[type];
  }

  Color? textColor() {
    return const <String, Color>{
      'normal': Colors.white,
      'dark': Colors.white,
      'transparent': DUColors.gray3,
      'success': DUColors.gray3,
      'warning': Colors.white,
      'disabled': DUColors.gray3,
      'normal_black': DUColors.black,
      'normal_tomato': DUColors.tomato,
      'decline': Colors.white,
    }[type];
  }
}

class DUButton extends StatelessWidget {
  // final Size size;
  final String text;
  final Function press;
  final EdgeInsets? margin;
  final double? width;
  final double height;
  final double radius;
  final ButtonType type;
  final double fontSize;
  final FontWeight fontWeight;
  DUButton(
      {
      // required this.size,
      Key? key,
      required this.text,
      required this.press,
      this.margin,
      this.width,
      this.height = 50,
      this.radius = 14,
      this.type = ButtonType.normal,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  Color? color = DUColors.tomato;
  Color? textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    color = type.buttonColor();
    textColor = type.textColor();
    return Container(
      // color: Colors.red,
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: TextButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
          onPressed: press as void Function()?,
          child: Text(
            text,
            style: DUTextStyle.size12.copyWith(
                color: textColor, fontSize: fontSize, fontWeight: fontWeight),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('height', height));
  }
}
