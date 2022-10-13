import 'dart:math';

import 'package:flutter/material.dart';

class DUSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  DUSliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.maxChild,
    required this.minChild,
    this.visibleMainHeight,
    this.animationVal,
    this.width,
  });
  final double? minHeight;
  final double? maxHeight;

  final Widget? maxChild;
  final Widget? minChild;

  double? visibleMainHeight, animationVal, width;

  @override
  bool shouldRebuild(DUSliverPersistentHeaderDelegate oldDelegate) => true;
  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => max(maxHeight!, minHeight!);

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;

    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed).clamp(0, 1).toDouble();
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    width = MediaQuery.of(context).size.width;
    visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    animationVal = scrollAnimationValue(shrinkOffset);

    return Container(
        height: visibleMainHeight,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFFFFFFF),
        child: Stack(
          children: <Widget>[
            getMinTop(),
            animationVal != 0 ? getMaxTop() : Container(),
          ],
        ));
  }

  Widget getMaxTop() {
    return Positioned(
      bottom: 0.0,
      child: Opacity(
        opacity: animationVal!,
        child: SizedBox(
          height: maxHeight,
          width: width,
          child: maxChild,
        ),
      ),
    );
  }

  Widget getMinTop() {
    return Opacity(
      opacity: 1 - animationVal!,
      child: Container(height: visibleMainHeight, width: width, child: minChild),
    );
  }
}
