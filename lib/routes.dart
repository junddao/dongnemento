import 'dart:async';

import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/bloc/singleton_me/singleton_me_cubit.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/util/simple_logger.dart';
import 'package:base_project/pages/00_etc/page_confirm.dart';
import 'package:base_project/pages/00_map/map_page.dart';
import 'package:base_project/pages/02_post/create_post_page.dart';
import 'package:base_project/pages/02_post/favorite_post_list_page.dart';
import 'package:base_project/pages/02_post/post_detail_page.dart';
import 'package:base_project/pages/03_more/more_page.dart';
import 'package:base_project/pages/common/address_page.dart';
import 'package:base_project/pages/common/error_page.dart';
import 'package:base_project/pages/login/login_page.dart';
import 'package:base_project/pages/login/page_email_sign_up.dart';
import 'package:base_project/pages/root_page.dart';
import 'package:base_project/pages/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'global/component/du_photo_viewer.dart';

class Routes {
  // 1 depth
  static const root = '/';
  // static const home = '/home';
  static const map = '/map';
  static const login = '/login';
  static const product = '/product';
  static const more = '/more';
  static const error = '/error';
  static const address = '/address';
  static const confirm = '/confirm';
  static const photoView = '/photo_view';

  // 2 depth
  static const signUp = 'sign_up';
  static const post = 'post';
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter extends Bloc {
  late final AuthenticationBloc authBloc;

  GoRouter get router => _goRouter;

  AppRouter(this.authBloc) : super(null);

  AuthenticationState? prevAuthState;

  late final _goRouter = GoRouter(
    redirect: (context, state) async {
      if (prevAuthState == authBloc.state) {
        return null;
      }
      prevAuthState = authBloc.state;
      if (authBloc.state is AuthenticationAuthenticated) {
        context.read<SingletonMeCubit>().updateSingletonMe(authBloc.state.me!);
        logger.d('Authenticated');
        return Routes.map;
      } else if (authBloc.state is AuthenticationUnAuthenticated) {
        context.read<SingletonMeCubit>().updateSingletonMe(ModelUser());
        logger.d('UnAuthenticated');
        return Routes.login;
      } else if (authBloc.state is AuthenticationUnknown) {
        logger.d('AuthenticationUnknown');
      } else if (authBloc.state is AuthenticationError) {
        logger.d('AuthenticationError');
        return Routes.login;
      } else {
        logger.d('?? auth else 탑니다.');
      }

      return null;
    },
    navigatorKey: rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    initialLocation: Routes.root,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.root,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const RootPage(),
          );
        },
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return MaterialPage(
            key: state.pageKey,
            child: TabPage(child: child),
          );
        },
        routes: [
          // GoRoute(
          //   path: Routes.home,
          //   pageBuilder: (context, state) {
          //     return const MaterialPage(
          //       child: HomePage(),
          //     );
          //   },
          // ),
          GoRoute(
            path: Routes.map,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: MapPage(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                path: Routes.post,
                builder: (context, state) {
                  return const CreatePostPage();
                },
              ),
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                path: '${Routes.post}/:id',
                builder: (context, state) {
                  String id = state.params['id']!;
                  return PagePostDetail(
                    id: id,
                  );
                },
              )
            ],
          ),
          GoRoute(
            path: Routes.product,
            pageBuilder: (context, state) {
              return const MaterialPage(child: FavoritePostListPage());
            },
          ),
          GoRoute(
            path: Routes.more,
            pageBuilder: (context, state) {
              return const MaterialPage(
                child: MorePage(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const LoginPage(),
          );
        },
        routes: [
          GoRoute(
            path: Routes.signUp,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: const PageEmailSignUp(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.address,
        pageBuilder: (context, state) {
          final Map<String, Function> params = state.extra! as Map<String, Function>;
          Function setAddress = params['setAddress'] as Function;
          return MaterialPage(
            child: AddressPage(
              setAddress: setAddress,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.confirm,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final params = state.extra! as Map<String, dynamic>;
          String title = params['title'];
          String contents1 = params['contents1'];
          String contents2 = params['contents2'];
          return MaterialPage(
            child: PageConfirm(
              title: title,
              contents1: contents1,
              contents2: contents2,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.photoView,
        name: Routes.photoView,
        pageBuilder: (context, state) {
          String? filePath = state.params as String;
          return MaterialPage(
            child: DUPhotoViewer(filePath: filePath),
          );
        },
      ),
      GoRoute(
        path: Routes.error,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: ErrorPage(exception: state.error.toString()),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(key: state.pageKey, child: ErrorPage(exception: state.error.toString()));
    },
    debugLogDiagnostics: true,
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
