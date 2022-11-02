import 'package:base_project/global/style/du_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabPage extends StatelessWidget {
  const TabPage({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageTabView(
      child: child,
    );
  }
}

class PageTabView extends StatefulWidget {
  const PageTabView({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<PageTabView> createState() => _PageTabViewState();
}

class _PageTabViewState extends State<PageTabView> with WidgetsBindingObserver {
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: _navigationBar(),
      ),
    );
  }

  Widget _body() {
    return widget.child;
  }

  Widget _navigationBar() {
    return BottomNavigationBar(
      onTap: (int idx) => _onItemTapped(idx, context),
      currentIndex: _calculateSelectedIndex(context),
      backgroundColor: DUColors.white02,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.maps_home_work_outlined),
          label: '지도',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_sharp),
          label: '인기글',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: '더보기',
        ),
      ],
      selectedFontSize: 11,
      unselectedFontSize: 11,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location == '/map') {
      _selectedPage = 0;
    }

    if (location == '/product') {
      _selectedPage = 1;
    }
    if (location == '/more') {
      _selectedPage = 2;
    }
    return _selectedPage;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/map');
        break;

      case 1:
        GoRouter.of(context).go('/product');
        break;
      case 2:
        GoRouter.of(context).go('/more');
        break;
    }
  }
}
