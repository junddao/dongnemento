import 'package:flutter/material.dart';

class DUSizedBox extends StatelessWidget {
  ///4배수 SizedBox(수치가 안맞는경우 반내림해서 사용)
  ///세로
  const DUSizedBox.h4({super.key, this.additionalValue = 0})
      : defaultValue = 4,
        isHeight = true;
  const DUSizedBox.h8({super.key, this.additionalValue = 0})
      : defaultValue = 8,
        isHeight = true;
  const DUSizedBox.h12({super.key, this.additionalValue = 0})
      : defaultValue = 12,
        isHeight = true;
  const DUSizedBox.h16({super.key, this.additionalValue = 0})
      : defaultValue = 16,
        isHeight = true;
  const DUSizedBox.h20({super.key, this.additionalValue = 0})
      : defaultValue = 20,
        isHeight = true;
  const DUSizedBox.h24({super.key, this.additionalValue = 0})
      : defaultValue = 24,
        isHeight = true;
  const DUSizedBox.h28({super.key, this.additionalValue = 0})
      : defaultValue = 28,
        isHeight = true;
  const DUSizedBox.h32({super.key, this.additionalValue = 0})
      : defaultValue = 32,
        isHeight = true;
  const DUSizedBox.h36({super.key, this.additionalValue = 0})
      : defaultValue = 36,
        isHeight = true;
  const DUSizedBox.h40({super.key, this.additionalValue = 0})
      : defaultValue = 40,
        isHeight = true;
  const DUSizedBox.h44({super.key, this.additionalValue = 0})
      : defaultValue = 44,
        isHeight = true;
  const DUSizedBox.h48({super.key, this.additionalValue = 0})
      : defaultValue = 48,
        isHeight = true;
  const DUSizedBox.h52({super.key, this.additionalValue = 0})
      : defaultValue = 52,
        isHeight = true;
  const DUSizedBox.h56({super.key, this.additionalValue = 0})
      : defaultValue = 56,
        isHeight = true;
  const DUSizedBox.h60({super.key, this.additionalValue = 0})
      : defaultValue = 60,
        isHeight = true;
  const DUSizedBox.h64({super.key, this.additionalValue = 0})
      : defaultValue = 64,
        isHeight = true;
  const DUSizedBox.h68({super.key, this.additionalValue = 0})
      : defaultValue = 68,
        isHeight = true;

  ///가로
  const DUSizedBox.w4({super.key, this.additionalValue = 0})
      : defaultValue = 4,
        isHeight = false;
  const DUSizedBox.w8({super.key, this.additionalValue = 0})
      : defaultValue = 8,
        isHeight = false;
  const DUSizedBox.w12({super.key, this.additionalValue = 0})
      : defaultValue = 12,
        isHeight = false;
  const DUSizedBox.w16({super.key, this.additionalValue = 0})
      : defaultValue = 16,
        isHeight = false;

  /// 기본값
  final double defaultValue;

  /// 추가값
  final double additionalValue;

  /// 세로 여부
  final bool isHeight;

  @override
  Widget build(BuildContext context) {
    return isHeight
        ? SizedBox(
            height: defaultValue + additionalValue,
          )
        : SizedBox(
            width: defaultValue + additionalValue,
          );
  }
}
