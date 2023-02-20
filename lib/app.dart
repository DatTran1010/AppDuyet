import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:viet_soft/UI/constants/themes.dart';
import 'package:viet_soft/UI/screens/navigation.dart';
import 'package:viet_soft/UI/screens/splash_screen/splash_screen.dart';
import 'package:viet_soft/services/notification_service.dart';

class VietSoft extends ConsumerStatefulWidget {
  const VietSoft({Key? key}) : super(key: key);

  @override
  ConsumerState<VietSoft> createState() => _VietSoftState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _VietSoftState extends ConsumerState<VietSoft> {
  @override
  void initState() {
    notificationSetting();
    super.initState();
  }

  void notificationSetting() async {
    NotificationService notificationService = NotificationService(ref);
    if (!kIsWeb) {
      await notificationService.setupFlutterNotification();
      notificationService.requestPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const MaterialClassicHeader(),
      footerBuilder: () => const ClassicFooter(
        loadStyle: LoadStyle.ShowAlways,
      ),
      child: MaterialApp(
        theme: VietSoftTheme.lightTheme,
        darkTheme: VietSoftTheme.darkTheme,
        onGenerateRoute: VietSoftRouter.generateRoute,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        navigatorKey: navigatorKey,
      ),
    );
  }
}
