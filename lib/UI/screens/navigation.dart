import 'package:flutter/material.dart';
import 'package:viet_soft/UI/screens/splash_screen/splash_screen.dart';

class VietSoftRouter {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String historyRoute = '/history';
  static const String updateRoute = '/update';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        // ignore: prefer_const_constructors
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // case homeRoute:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      // case historyRoute:
      //   return MaterialPageRoute(builder: (_) => History());
      // case updateRoute:
      //   return MaterialPageRoute(builder: (_) => Update());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
