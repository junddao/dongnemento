import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../model/firebase/firebase_model.dart';
import '../../util/simple_logger.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
  logger.d('onDidReceiveBackgroundNotificationResponse');
  // GoRouter.of(rootNavigatorKey.currentContext!).go(notificationResponse.payload ?? Routes.home);
}

/// 포그라운드 상태에서 수신
Future<void> _foregroundFCMHandler(RemoteMessage message) async {
  firebaseMessagingHandler(message);
}

/// 백그라운드 상태에서 수신
Future<void> _backgroundFCMHandler(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    firebaseMessagingHandler(message);
  }
}

class FCMWrapper {
  static final FCMWrapper instance = FCMWrapper._internal();

  static final _firebaseMessaging = FirebaseMessaging.instance;

  factory FCMWrapper() {
    return instance;
  }

  FCMWrapper._internal();

  Future<void> initialize() async {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      return;
    }

    //1. get message when app states is closed
    await getInitialMessaging();

    //2. request permission
    await requestPermission();

    //3. init push Information + add onClick Event
    await initPushInformation();

    //4. ForegroundMethod listener - Flutter Local Notification으로 올립니다.
    FirebaseMessaging.onMessage.listen(_foregroundFCMHandler);

    //5. BackgroundMethod listener - Flutter Local Notification으로 올립니다.
    FirebaseMessaging.onBackgroundMessage(_backgroundFCMHandler);
  }

  Future<void> getInitialMessaging() async {
    RemoteMessage? message = await _firebaseMessaging.getInitialMessage();
    if (message?.data != null) {
      logger.d('getInitialMessaging');
      logger.d(message?.data);
    }
  }

  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
  }

  Future<void> initPushInformation() async {
    // FLN 초기화
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationsSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,

      /// click push message event
      onDidReceiveNotificationResponse: (details) async {
        // GoRouter.of(rootNavigatorKey.currentContext!).go(details.payload ?? Routes.home);
      },

      /// 이건 언제 타는거지..
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  // PUSH를 보내기위해 식별할 수 있는 토큰 추출 (JWT 인증 토큰 아님)
  Future<String> getToken() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        var token = await _firebaseMessaging.getToken();

        if (token == null) {
          throw Exception("can not get fcm token");
        }
        logger.d('fcm: $token');
        return token;
      }
      return Future.value("this_is_desktop_firebase_token");
    } catch (e) {
      rethrow;
    }
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

  // 뱃지 카운터
  void badgeCount(int count) {
    try {
      if (count == 0) {
        FlutterAppBadger.removeBadge();
      } else {
        FlutterAppBadger.updateBadgeCount(count);
      }
    } finally {}
  }
}

// foreground일 때 push 알림을 보내기위한 FlutterLocalNotificationsPlugin 이하 FLN
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
String? flutterLocalAppLaunchDetailsPayload;

/// 채팅방 룸 진입여부 체크용 변수(진입한 채팅방에서 알림 방지)
List<String> newsDetailRoomIds = [];

// FCM 수신시 데이터 처리
Future<void> firebaseMessagingHandler(RemoteMessage message) async {
  logger.d(message.notification?.title ?? '');

  FirebaseModel fcmModel = FirebaseModel.fromJson(message.data);

  // add badge
  // FCMWrapper.instance.badgeCount(int.parse(fcmModel.badge ?? '0'));
  showNotification(fcmModel);
}

// FLN Push 알림
Future<void> showNotification(FirebaseModel fcmModel) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );

  String? payload;

  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(0, fcmModel.title, fcmModel.body, platformChannelSpecifics,
      payload: payload);
}
