import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:viet_soft/app.dart';
import 'package:viet_soft/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await Hive.initFlutter();
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  final counterStateProvider = StateProvider<int>((ref) {
    return 0;
  });
  print('User granted permission: ${settings.authorizationStatus}');
  print("token firebase ${await messaging.getToken()}");

  runApp(
    const ProviderScope(
      child: VietSoft(),
    ),
  );
}
