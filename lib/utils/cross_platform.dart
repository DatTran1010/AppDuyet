import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CrossPlatform {
  static dynamic transitionToPage(
    BuildContext context,
    dynamic destination, {
    bool newPage = false,
  }) {
    FocusScopeNode currFocus = FocusScope.of(context);

    if (!currFocus.hasPrimaryFocus) {
      currFocus.unfocus();
    }

    if (!newPage) {
      return Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => destination,
          transitionsBuilder: (c, anim, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => destination,
          transitionsBuilder: (c, anim, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  static dynamic pushAndRemoveAll(BuildContext context, dynamic destination) {
    return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => destination,
          transitionsBuilder: (c, anim, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        ModalRoute.withName("/"));
  }

  static dynamic showBottomSheet(BuildContext context,
      {required Widget child,
      double borderRadius = 10,
      Color backgroundColor = Colors.white}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
        builder: (BuildContext context) {
          return child;
        });
  }

  static Future<Flushbar> showSuccesSnackbar(
    BuildContext context,
    String content, {
    int duration = 2000,
    int animationDuration = 1000,
  }) async {
    return Flushbar(
      message: content,
      duration: Duration(milliseconds: duration),
      animationDuration: Duration(milliseconds: animationDuration),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: const Icon(
        Icons.done,
        color: Colors.white,
      ),
    )..show(context);
  }

  static dynamic backTransitionPage(
    BuildContext context, {
    dynamic value,
  }) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, value);
      return value;
    }
    return;
  }

  static Future<Flushbar> showErrorSnackbar(
    BuildContext context,
    String content, {
    int duration = 3000,
    int animationDuration = 1000,
  }) async {
    return Flushbar(
      message: content,
      duration: Duration(milliseconds: duration),
      animationDuration: Duration(milliseconds: animationDuration),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    )..show(context);
  }

  static dynamic showLoadingAlert(
      BuildContext context, String textInfo, bool isShowed) {
    if (isShowed) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Platform.isIOS
                ? CupertinoAlertDialog(
                    title: const CupertinoActivityIndicator(),
                    content: Text(
                      textInfo,
                    ),
                  )
                : AlertDialog(
                    title: const SpinKitFadingCircle(
                      color: Color(0xFF0072BB),
                      size: 50,
                    ),
                    content: Text(
                      textInfo,
                    ),
                  );
          });
    }
    Navigator.pop(context);
    return null;
  }

  static Future<dynamic>? showConfirmationAlert(
      BuildContext context, Widget titleWidget, Widget subtitleWidget,
      {Function? onProceedClick,
      String infoLabel = 'Proceed',
      String? cancel}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Platform.isIOS
              ? CupertinoAlertDialog(
                  title: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: titleWidget,
                  ),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text(
                        cancel ?? 'Close',
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                        ConfirmAction.cancel,
                      ),
                    ),
                    CupertinoDialogAction(
                      child: Text(
                        infoLabel,
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                        ConfirmAction.accept,
                      ),
                    ),
                  ],
                )
              : AlertDialog(
                  title: titleWidget,
                  actions: <Widget>[
                    IdealicCommonButton(
                      color: Colors.white,
                      child: Text(
                        cancel ?? 'Cancel',
                        style: const TextStyle(color: Color(0xFF0078FF)),
                      ),
                      onPress: () => Navigator.pop(
                        context,
                        ConfirmAction.cancel,
                      ),
                    ),
                    IdealicCommonButton(
                      color: const Color(0xFF0078FF),
                      child: Text(
                        infoLabel,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPress: () => Navigator.pop(
                        context,
                        ConfirmAction.accept,
                      ),
                    ),
                  ],
                );
        });
  }
}

enum ConfirmAction { cancel, accept }

class IdealicCommonButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPress;
  final double? radius;
  final Color color;
  const IdealicCommonButton({
    super.key,
    required this.child,
    this.onPress = _defaultBtnCommonPressed,
    this.radius = 10,
    this.color = Colors.white,
  });

  @override
  IdealicCommonButtonState createState() => IdealicCommonButtonState();
}

class IdealicCommonButtonState extends State<IdealicCommonButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.radius!),
          ),
        ),
      ),
      onPressed: widget.onPress,
      child: widget.child,
    );
  }
}

void _defaultBtnCommonPressed() {}
