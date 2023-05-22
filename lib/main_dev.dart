import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'main.dart';

void main() async {
  KakaoSdk.init(nativeAppKey: '8548a68be13838496d1f23538f9f8ce7');

  FlavorConfig(
    name: "dev",
    variables: {
      "EndPoint": "http://10.0.2.2:17008/dev",
      // "EndPoint": "http://43.200.119.214/dev",
    },
  );

  //앱 세팅
  await platformSetup();

  //앱 실행
  runApp(const MyApp());
}
