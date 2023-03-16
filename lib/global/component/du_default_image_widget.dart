import 'package:flutter/material.dart';

class DUDefaultImageWidget extends StatelessWidget {
  const DUDefaultImageWidget({super.key, this.height, this.width, this.borderRadius = 4});

  final double? height;
  final double? width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        'assets/images/default_image.png',
        fit: BoxFit.cover,
        height: height,
        width: width,
      ),
    );
  }
}
