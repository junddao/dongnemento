import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/component/du_nested_scroll_view/du_sliver_persistent_header_delegate.dart';
import 'package:flutter/material.dart';

class DUNestedScrollView extends StatelessWidget {
  const DUNestedScrollView(
      {super.key,
      required this.maxChild,
      required this.minChild,
      this.minHeight,
      required this.maxHeight,
      required this.body});

  final Function maxChild;
  final Function minChild;
  final double? minHeight;
  final double maxHeight;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
            sliver: SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: DUSliverPersistentHeaderDelegate(
                maxChild: maxChild(),
                minChild: minChild(),
                minHeight: minHeight ?? AppBar().preferredSize.height,
                maxHeight: maxHeight,
              ),
            ),
          ),
          // SliverOverlapAbsorber(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),

          // const SliverPersistentHeader(
          //   pinned: true,
          //   // floating: true,
          //   delegate: MyDelegate(),
          // ),
        ];
      },
      body: body,

      // appBar: _appBar(),
      // body: _body(),
    );
  }
}
