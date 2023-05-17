import 'package:base_project/env.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:go_router/go_router.dart';

import '../../routes.dart';
import '../util/simple_logger.dart';

class DynamicLink {
  static final DynamicLink _instance = DynamicLink._internal();

  factory DynamicLink() {
    return _instance;
  }

  late GoRouter _goRouter;

  static DynamicLink get instance => _instance;
  DynamicLink._internal() {
    //do something
  }

  Future<void> navigation(String page, {String id = ''}) async {
    late String path;
    if (page.isEmpty) {
      path = Routes.map;
    } else {
      path = id.isEmpty ? page : '$page/$id';
    }

    _goRouter.go(path);
  }

  Future<bool> setup(GoRouter router) async {
    _goRouter = router;
    bool isExistDynamicLink = await _getInitialDynamicLink();
    _addListener();

    return isExistDynamicLink;
  }

  Future<bool> _getInitialDynamicLink() async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      PendingDynamicLinkData? dynamicLinkData = await FirebaseDynamicLinks.instance.getDynamicLink(initialLink.link);

      if (dynamicLinkData != null) {
        await _redirectScreen(dynamicLinkData);

        return true;
      }
    }

    return false;
  }

  void _addListener() {
    FirebaseDynamicLinks.instance.onLink.listen((
      PendingDynamicLinkData dynamicLinkData,
    ) async {
      await _redirectScreen(dynamicLinkData);
    }).onError((error) {
      logger.e(error);
    });
  }

  Future<void> _redirectScreen(PendingDynamicLinkData dynamicLinkData) async {
    // if (dynamicLinkData.link.queryParameters.containsKey('id')) {
    //   String link = '/${dynamicLinkData.link.path.split('/').last}';
    //   String id = dynamicLinkData.link.queryParameters['id']!;

    //   if (link.contains(Routes.campus)) {
    //     navigation(Routes.campus, id: id);
    //   }
    //   if (link.contains(Routes.userProfile)) {
    //     MeModel? me = await Storage.instance.readMyInfo();
    //     String myId = me?.id ?? '';
    //     if (id == myId) {
    //       navigation(Routes.myProfile);
    //     } else {
    //       navigation(Routes.userProfile, id: id);
    //     }
    //   }
    //   if (link.contains(Routes.feed)) {
    //     String url = path.join(Routes.home, Routes.feed);
    //     navigation(url, id: id);
    //   }
    // }
  }

  Future<String> getShortLink(String screenName, String id) async {
    String packageName = '';

    if (Env.opMode == OpMode.dev) packageName = 'com.jj.dongnesosik.dev';
    if (Env.opMode == OpMode.prod) packageName = 'com.jj.dongnesosik';

    String dynamicLinkPrefix = 'https://dongnesosik.page.link';
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: dynamicLinkPrefix,
      link: Uri.parse('$dynamicLinkPrefix$screenName?id=$id'),
      androidParameters: AndroidParameters(
        packageName: packageName,
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: packageName,
        minimumVersion: '0',
      ),
    );

    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl.toString();
  }
}
