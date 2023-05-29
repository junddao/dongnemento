import 'dart:async';

import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:base_project/global/style/constants.dart';
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
import 'package:base_project/pages/login/page_set_location.dart';
import 'package:base_project/pages/root_page.dart';
import 'package:base_project/pages/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'global/bloc/auth/get_me/me_cubit.dart';
import 'global/component/du_photo_viewer.dart';
import 'global/enum/authentication_status_type.dart';
import 'pages/02_post/my_post_page.dart';
import 'pages/02_post/page_select_location.dart';

class Routes {
  // 1 depth
  static const root = '/';
  // static const home = '/home';
  static const map = '/map';
  static const login = '/login';
  static const favoritePost = '/favorite_post';
  static const myPost = '/my_post';

  static const more = '/more';
  static const error = '/error';
  static const address = '/address';
  static const selectLocation = '/select_location';
  static const confirm = '/confirm';
  static const photoView = '/photo_view';
  static const introAddress = '/intro_address';

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
      SizeConfig().init(context);
      if (prevAuthState == authBloc.state) {
        return null;
      }
      prevAuthState = authBloc.state;
      if (authBloc.state is AuthenticationInitial) {
        var result = await SecureStorage.instance.readToken();

        if (result != null) {
          authBloc.add(const AuthenticationStatusChanged(status: AuthenticationStatusType.authenticated));
        }
        return null;
      } else if (authBloc.state is AuthenticationAuthenticated) {
        // 최초 가입시 좌표값이 없어 주소 입력창으로 이동
        if (authBloc.state.me!.lat == null || authBloc.state.me!.lng == null) {
          return Routes.introAddress;
        }

        logger.d('Authenticated');
        context.read<MeCubit>().setMe(authBloc.state.me!);
        return Routes.map;
      } else if (authBloc.state is AuthenticationUnAuthenticated) {
        // context.read<SingletonMeCubit>().updateSingletonMe(ModelUser());
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
      return Routes.login;
      // return null;
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
                path: '${Routes.post}/:id/:userId',
                builder: (context, state) {
                  String id = state.params['id']!;
                  String userId = state.params['userId']!;
                  return PagePostDetail(
                    id: id,
                    userId: userId,
                  );
                },
              )
            ],
          ),
          GoRoute(
            path: Routes.favoritePost,
            pageBuilder: (context, state) {
              return const MaterialPage(child: FavoritePostListPage());
            },
          ),
          GoRoute(
            path: Routes.myPost,
            pageBuilder: (context, state) {
              return const MaterialPage(child: MyPostPage());
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
          return const MaterialPage(
            child: AddressPage(),
          );
        },
      ),
      GoRoute(
        path: Routes.selectLocation,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          LatLng location = extra['location'] as LatLng;
          return MaterialPage(
            child: PageSelectLocation(
              location: location,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.introAddress,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: PageSetLocation(),
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
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final queryParams = state.extra as Map<String, dynamic>;
          String filePath = queryParams['filePath'] as String;

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
