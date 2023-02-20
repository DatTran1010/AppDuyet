import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/constants/size.dart';
import 'package:viet_soft/UI/screens/authentication/login/login.dart';
import 'package:viet_soft/logic/models/user.dart';
import 'package:viet_soft/repositories/home_repository.dart';
import 'package:viet_soft/utils/cross_platform.dart';

class VietSoftDrawer extends ConsumerWidget {
  const VietSoftDrawer({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(RequestNotifier.provider(user));

    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "CÔNG TY CỔ PHẦN MAY DUY MINH",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/logo/logo_vietsoft.png",
                            width: VietSoftSize.getSize(239, context),
                            height: VietSoftSize.getSize(239, context),
                          ),
                          const Text(
                            "Duyệt tài liệu",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: OutlinedButton(
                    onPressed: () {
                      ref
                          .read(RequestNotifier.provider(user).notifier)
                          .logOut();
                      CrossPlatform.pushAndRemoveAll(context, Login());
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    child: const Text(
                      "Đăng xuất",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
