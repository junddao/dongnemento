import 'package:base_project/global/style/constants.dart';
import 'package:base_project/pages/00_home/components/event_widget.dart';
import 'package:base_project/pages/00_home/components/home_intro_widget.dart';
import 'package:base_project/pages/00_home/components/magazine_widget.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: _body(),
    );
  }

  // DUAppBar _appBar() {
  //   return DUAppBar(
  //     automaticallyImplyLeading: false,
  //     centerTitle: false,
  //     title: Text('홈'),
  //   );
  // }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultVerticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding),
              child: HomeIntroWidget(goUserGuide: () {}),
            ),

            const SizedBox(height: 12),

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
            // magagineWidget(),
            // nationalSupportProjectWidget(),
          ],
        ),
      ),
    );
  }
}
