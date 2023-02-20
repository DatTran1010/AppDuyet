// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/screens/authentication/login/login.dart';
import 'package:viet_soft/UI/screens/update/update_screen.dart';
import 'package:viet_soft/app.dart';
import 'package:viet_soft/repositories/login_repository.dart';
import 'package:viet_soft/services/login_service.dart';
import 'package:viet_soft/services/notification_service.dart';
import 'package:viet_soft/utils/cross_platform.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    onMessage();
    super.initState();
  }

  onMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handelInitalValue(initialMessage);
    } else {
      CrossPlatform.transitionToPage(context, Login());
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  void showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    LoginService loginService = ref.read(LoginService.provider);

    int userId = int.parse(message.data["iduser"]);
    int requestId = int.parse(message.data["iddqt"]);
    var payloadMap = {
      "message": message.toMap(),
    };
    if (loginService.user != null) {
      payloadMap["user"] = loginService.user!.toJson();
    } else {
      LoginNotifier loginNotifier = ref.read(LoginNotifier.provider.notifier);
      loginNotifier.userId = userId;
      loginNotifier.requestId = requestId;
    }
    String payload = jsonEncode(payloadMap);
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

  void _handelInitalValue(RemoteMessage message) async {
    int userId = int.parse(message.data["iduser"]);
    int requestId = int.parse(message.data["iddqt"]);

    await CrossPlatform.transitionToPage(context, Login());
    LoginNotifier loginNotifier = ref.read(LoginNotifier.provider.notifier);
    loginNotifier.userId = userId;
    loginNotifier.requestId = requestId;
  }

  void _handleMessage(RemoteMessage message) async {
    LoginService loginService = ref.read(LoginService.provider);

    int userId = int.parse(message.data["iduser"]);
    int requestId = int.parse(message.data["iddqt"]);
    if (loginService.user != null) {
      CrossPlatform.transitionToPage(
        navigatorKey.currentState!.context,
        UpdateScreen(
          requestId: requestId,
          user: loginService.user!,
          isOpenFromNoti: true,
        ),
      );
    } else {
      LoginNotifier loginNotifier = ref.read(LoginNotifier.provider.notifier);
      loginNotifier.userId = userId;
      loginNotifier.requestId = requestId;
      CrossPlatform.showErrorSnackbar(navigatorKey.currentState!.context,
          "Sau khi đăng nhập chuyển đến duyệt tài liệu!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const SafeArea(
        child: Text(
          "Loading ...",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Image.asset(
          "assets/logo/logo_vietsoft@3x.png",
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
