import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/screens/authentication/login/login.dart';
import 'package:viet_soft/app.dart';
import 'package:viet_soft/utils/cross_platform.dart';
import 'package:viet_soft/utils/enum/api_error.dart';

class HandleError {
  static handleUnauthorized(BuildContext context, Object? error) {
    var exception = error as APIError;
    if (exception == APIError.unauthorized) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
      CrossPlatform.transitionToPage(
          navigatorKey.currentState!.context, Login());
      CrossPlatform.showErrorSnackbar(
          context, "Hết hạn token! Vui lòng đăng nhập lại");
    } else {
      CrossPlatform.showErrorSnackbar(context, "Unknown error");
    }
  }

  static handleUnauthNoti(BuildContext context, Object? error, int userId,
      int requestId, WidgetRef ref) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CrossPlatform.pushAndRemoveAll(
          navigatorKey.currentState!.context,
          Login(
            userId: userId,
            requestId: requestId,
          ));
    });

    // print("handleUnauthNoti");
    // LoginNotifier loginNotifier = ref.read(LoginNotifier.provider.notifier);
    // loginNotifier.userId = userId;
    // loginNotifier.requestId = requestId;

    // print("${loginNotifier.userId} - ${loginNotifier.requestId}");
    CrossPlatform.showErrorSnackbar(navigatorKey.currentState!.context,
        "Sau khi đăng nhập chuyển đến duyệt yêu cầu");
  }

  static throwAPIError(code) {
    if (code == 401) {
      throw APIError.unauthorized;
    } else {
      throw APIError.unknown;
    }
  }
}
