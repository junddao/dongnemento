import 'dart:async';
import 'dart:io';

import 'package:base_project/global/service/firebase/firebase_fcm_func.dart';
import 'package:base_project/global/service/firebase/firebase_msg_data_entity.dart';
import 'package:base_project/global/service/firebase/firebase_options.dart';
import 'package:eraser/eraser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// foreground일 때 push 알림을 보내기위한 FlutterLocalNotificationsPlugin 이하 FLN
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
String? flutterLocalAppLaunchDetailsPayload;

// Platform에 따른 초기화
InitializationSettings initializationSettings() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  IOSInitializationSettings initializationSettingsIOS = const IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  return InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
}

/// 채팅방 룸 진입여부 체크용 변수(진입한 채팅방에서 알림 방지)
List<String> newsDetailRoomIds = [];

// FCM 수신시 데이터 처리
Future<void> firebaseMessagingHandler(RemoteMessage message) async {
  print('call firebaseMessagingHandler');

  if (Platform.isAndroid) {
    // foreground와 background가 모두 이 루틴을 탑니다.
    if (newsDetailRoomIds.isEmpty || newsDetailRoomIds.last != message.data["roomId"]) {
      showNotification(message);
    }
    FCMWrapper.instance.badgeCount(message);
  } else if (Platform.isIOS) {
    // foreground만 이 루틴을 탑니다.
    if (newsDetailRoomIds.isEmpty || newsDetailRoomIds.last != message.data["roomId"]) {
      showNotification(message);
      FCMWrapper.instance.badgeCount(message);
    }
  }
}

// FLN Push 알림
Future<void> showNotification(RemoteMessage message) async {
  debugPrint('FlutterLocalNotificationsPlugin : showNotification');

  if (message.data["title"] == null) return;

  String title = message.data["title"] ?? '제목';
  String body = message.data["body"] ?? '내용';
  String roomId = message.data["roomId"] ?? '';

  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'du_id_fcm_channel',
    'du_fcm_channel',
    channelDescription: 'du_fcm_channel_description...',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    tag: roomId,
  );
  NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: roomId);
}

/// 관련된 알림 제거
void closeNotification(String roomId) {
  flutterLocalNotificationsPlugin.cancel(0, tag: roomId);
}

enum PUSHEVENT { unknown, innerPush, outerPush }

class FCMWrapper {
  static final FCMWrapper instance = FCMWrapper._internal();

  static final _firebaseMessaging = FirebaseMessaging.instance;

  factory FCMWrapper() {
    return instance;
  }

  // ignore: close_sinks
  final _controller = StreamController<PUSHEVENT>();

  Stream<PUSHEVENT> get status async* {
    yield PUSHEVENT.unknown;
    yield* _controller.stream;
  }

  FCMWrapper._internal();

  // PUSH를 보내기위해 식별할 수 있는 토큰 추출 (JWT 인증 토큰 아님)
  Future<String> getToken() async {
    if (Platform.isAndroid || Platform.isIOS) {
      var token = await _firebaseMessaging.getToken();
      if (token == null) {
        throw Exception("can not get fcm token");
      }
      return token;
    }
    return Future.value("this_is_desktop_firebase_token");
  }

  Future<void> initialize() async {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      return;
    }
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        name: "post",
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    iOSPermission();

    // ForegroundMethod listener - FLN으로 올립니다.
    FirebaseMessaging.onMessage.listen((message) async => firebaseMessagingHandler(message));

    // BackgroundMethod listener - FLN으로 올립니다. - Android
    if (Platform.isAndroid) {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandler);
    }

    if (Platform.isIOS) {
      // 백그라운드 알림 클릭 이벤트 - iOS
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('FirebaseMessaging.onMessageOpenedApp $message');
        if (message.data['roomId'] != null) {
          fcmSelectNotification(roomId: message.data['roomId']);
        }
      });

      // 앱이 꺼져있는 상태에서 알림을 클릭하여 열기
      FirebaseMessaging.instance.getInitialMessage().then((message) async {
        print('FirebaseMessaging.instance.getInitialMessage $message');
        if (message?.data['roomId'] != null) {
          flutterLocalAppLaunchDetailsPayload = message!.data['roomId'];
        }
      });

      // 받아놓온 알림을 모두 삭제합니다.
      Eraser.clearAllAppNotifications();
    }

    // FLN 초기화
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings(),
      // Foreground(포그라운드에서 알림 클릭시 실행함)
      onSelectNotification: (payload) {
        if (payload != null) {
          fcmSelectNotification(roomId: payload);
        }
      },
    );

    // FLN background용 payload 저장
    var details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp && details.payload != null) {
      flutterLocalAppLaunchDetailsPayload = details.payload;
    }
  }

  void iOSPermission() {
    _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
  }

  void subscribe() {
    if (Platform.isIOS) {
      _firebaseMessaging.subscribeToTopic('ios-all');
    }
    if (Platform.isAndroid) {
      _firebaseMessaging.subscribeToTopic('android-all');
    }
  }

  Future<void> unsubscribe() async {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      return;
    }
    await _firebaseMessaging.deleteToken();
    if (Platform.isIOS) {
      _firebaseMessaging.unsubscribeFromTopic('ios-all');
    }
    if (Platform.isAndroid) {
      _firebaseMessaging.unsubscribeFromTopic('android-all');
    }
  }

  // Fcm 데이터 가져오기
  Future<FirebaseMsgDataEntity?> fcmConvertData() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage == null) return null;

    return FirebaseMsgDataEntity.fromMap(initialMessage.data);
  }

  // 뱃지 카운터
  void badgeCount(RemoteMessage message) {
    try {
      int count = int.parse(message.data["badge"]);

      if (count == 0) {
        FlutterAppBadger.removeBadge();
      } else {
        FlutterAppBadger.updateBadgeCount(count);
      }
    } finally {}
  }
}
