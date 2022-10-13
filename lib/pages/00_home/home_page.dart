import 'package:base_project/global/component/du_nested_scroll_view/du_nested_scroll_view.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:base_project/pages/00_home/components/event_widget.dart';
import 'package:base_project/pages/00_home/components/home_intro_widget.dart';
import 'package:base_project/pages/00_home/components/magazine_widget.dart';
import 'package:base_project/pages/00_home/components/my_delegate.dart';
import 'package:base_project/global/component/du_nested_scroll_view/du_sliver_persistent_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final double sliverMaxHeight = 200.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: DUNestedScrollView(
          body: _body(),
          maxChild: maxChild,
          minChild: minChild,
          maxHeight: sliverMaxHeight,
        ),
      ),
    );
  }

  Widget minChild() {
    return AppBar(
      title: const Text('3분 컨설팅 요청은 동네멘토!'),
    );
  }

  Widget maxChild() {
    return SizedBox(
      height: sliverMaxHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Text('3분이면', style: DUTextStyle.size24B),
          Text('컨설팅 요청 끝!', style: DUTextStyle.size24B),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultVerticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
              child: EventWidget(openEvent: () {}),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultHorizontalPadding),
              child: MagazineWidget(openMagazine: () {}),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
