import 'dart:async';

import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/util/simple_logger.dart';
import 'package:base_project/pages/00_home/home_page.dart';
import 'package:base_project/pages/01_chat/chat_detail_page.dart';
import 'package:base_project/pages/01_chat/chat_page.dart';
import 'package:base_project/pages/02_product/product_page.dart';
import 'package:base_project/pages/03_more/more_page.dart';
import 'package:base_project/pages/common/error_page.dart';
import 'package:base_project/pages/login/login_page.dart';
import 'package:base_project/pages/root_page.dart';
import 'package:base_project/pages/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        logger.d('Authenticated');
        return '/home';
      } else if (authBloc.state is AuthenticationUnAuthenticated) {
        logger.d('UnAuthenticated');
        return '/loginPage';
      } else if (authBloc.state is AuthenticationUnknown) {
        logger.d('AuthenticationUnknown');
      } else {
        logger.d('hahaha');
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const RootPage(),
          );
        },
      ),
      ShellRoute(
        pageBuilder: (context, state, child) {
          return MaterialPage(
            key: state.pageKey,
            child: TabPage(child: child),
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) {
              return const MaterialPage(child: HomePage());
            },
          ),
          GoRoute(
            path: '/chat',
            pageBuilder: (context, state) {
              return const MaterialPage(child: ChatPage());
            },
            routes: [
              GoRoute(
                path: 'details/:id',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return MaterialPage(
                    child: ChatDetailPage(id: state.params['id']!),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/product',
            pageBuilder: (context, state) {
              return const MaterialPage(child: ProductPage());
            },
          ),
          GoRoute(
            path: '/more',
            pageBuilder: (context, state) {
              return const MaterialPage(child: MorePage());
            },
          ),
        ],
      ),
      GoRoute(
        path: '/loginPage',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const LoginPage(),
          );
        },
        routes: [],
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(key: state.pageKey, child: ErrorPage(exception: state.error));
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
