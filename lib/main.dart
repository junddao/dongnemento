import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/bloc/auth/get_me/me_cubit.dart';
import 'package:base_project/global/bloc/map/get_pins/get_pins_cubit.dart';
import 'package:base_project/global/bloc/map/location/location_cubit.dart';
import 'package:base_project/global/theme/theme.dart';
import 'package:base_project/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'firebase_options.dart' as firebase_option;
import 'global/service/dynamic_link.dart';
import 'global/service/firebase/firebase_fcm.dart';
import 'global/style/du_colors.dart';

// void main() async {
//   KakaoSdk.init(nativeAppKey: '8548a68be13838496d1f23538f9f8ce7');

//   const isLiveMode = bool.fromEnvironment("flavor", defaultValue: false);

//   if (isLiveMode) {
//     FlavorConfig(
//       name: "prod",
//       variables: {
//         "EndPoint": "http://43.200.119.214/prod",
//       },
//     );
//   } else {
//     FlavorConfig(
//       name: "dev",
//       variables: {
//         "EndPoint": "http://43.200.119.214/dev",
//       },
//     );
//   }

//   //앱 세팅
//   await platformSetup();

//   //앱 실행
//   runApp(const MyApp());
// }

Future<void> platformSetup() async {
  // Flutter 엔진과 위젯의 바인딩 작업
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'dongnesosik',
    options: firebase_option.DefaultFirebaseOptions.currentPlatform,
  );

  // firebase 초기화
  await FCMWrapper.instance.initialize();

  // 가로모드 제어
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // 다국어 기본 한국어로 적용
  Intl.defaultLocale = 'ko_KR';
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthenticationBloc authBloc = AuthenticationBloc();
  // SingletonMeCubit singletonMeCubit = SingletonMeCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authBloc,
        ),
        BlocProvider(
          create: (context) => AppRouter(authBloc),
        ),
        // BlocProvider<SingletonMeCubit>(
        //   create: (context) => singletonMeCubit,
        // ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
        BlocProvider(
          create: (context) => MeCubit(),
        ),
        BlocProvider(
          create: (context) => GetPinsCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          GoRouter router = context.watch<AppRouter>().router;
          // init dynamic link
          DynamicLink.instance.setup(router);
          return MyFlavorBanner(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              title: '동네소식',
              theme: lightTheme(),
              localizationsDelegates: const [
                //다국어 지원
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ko', 'KR'),
                Locale('en', 'US'),
              ],

              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },

              //! dark mode 일때 사용 (theme.dart > darkTheme 수정해서 사용하세요.)
              // darkTheme: darkTheme(),
            ),
          );
        },
      ),
    );
  }
}

class MyFlavorBanner extends StatelessWidget {
  const MyFlavorBanner({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => FlavorConfig.instance.name == 'prod'
      ? child
      : FlavorBanner(
          location: BannerLocation.bottomEnd,
          color: DUColors.red01,
          child: child,
        );
}
