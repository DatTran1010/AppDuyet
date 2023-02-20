import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/screens/update/update_screen.dart';
import 'package:viet_soft/app.dart';
import 'package:viet_soft/utils/cross_platform.dart';

import '../logic/models/user.dart';

bool isFlutterLocalNotificationsInitialized = false;
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService.withOutRef() {
    return _notificationService;
  }
  factory NotificationService(WidgetRef ref) {
    ref = ref;
    return _notificationService;
  }
  NotificationService._internal();

  static bool notificationsEnabled = false;

  Future<void> setupFlutterNotification() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'main_channel',
      'Main Channel',
      importance: Importance.max,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwom =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwom);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTapNotification);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    String payload = jsonEncode(message.toMap());
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  icon: '@mipmap/ic_launcher')),
          payload: payload);
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestPermission();
    }
  }

  void _handleMessage(RemoteMessage message, User user) async {
    int requestId = int.parse(message.data["iddqt"]);

    CrossPlatform.pushAndRemoveAll(
      navigatorKey.currentState!.context,
      UpdateScreen(
        requestId: requestId,
        user: user,
        isOpenFromNoti: true,
      ),
    );
  }

  void onTapNotification(NotificationResponse notificationResponse) {
    if (notificationResponse.payload != null) {
      Map payload = jsonDecode(notificationResponse.payload!);
      RemoteMessage message = RemoteMessage.fromMap(payload["message"]);

      if (payload.containsKey("user")) {
        User user = User.fromJson(payload["user"]);
        _handleMessage(message, user);
      }
    }
  }
}
