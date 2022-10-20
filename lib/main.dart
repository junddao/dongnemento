import 'package:base_project/env.dart';
import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/bloc/map/location/location_cubit.dart';
import 'package:base_project/global/bloc/singleton_me/singleton_me_cubit.dart';
import 'package:base_project/global/theme/theme.dart';
import 'package:base_project/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'firebase_options.dart';

void main() async {
  //앱 세팅
  await platformSetup();

  //앱 실행
  runApp(const MyApp());
}

Future<void> platformSetup() async {
  // Flutter 엔진과 위젯의 바인딩 작업
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // firebase 초기화
  // await FCMWrapper.instance.initialize();

  // 가로모드 제어
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // 다국어 기본 한국어로 적용
  Intl.defaultLocale = 'ko_KR';

  // 기본설정
  Env();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc authBloc = AuthenticationBloc();
  SingletonMeCubit singletonMeCubit = SingletonMeCubit();

  @override
  void initState() {
    GetIt.I.registerSingleton(singletonMeCubit);
    super.initState();
  }

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
        BlocProvider(
          create: (context) => SingletonMeCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          GoRouter router = context.read<AppRouter>().router;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            title: 'Base Project',
            theme: lightTheme(),

            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },

            //! dark mode 일때 사용 (theme.dart > darkTheme 수정해서 사용하세요.)
            // darkTheme: darkTheme(),
          );
        },
      ),
    );
  }
}
