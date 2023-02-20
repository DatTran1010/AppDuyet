import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/repositories/absent_repository.dart';
import 'package:viet_soft/utils/cross_platform.dart';
import 'package:viet_soft/utils/handle_error.dart';

class VietSoftAppBar extends ConsumerWidget {
  const VietSoftAppBar(
      {super.key,
      required this.title,
      required this.userName,
      this.onTap,
      required this.userId});
  final String title;
  final String userName;
  final VoidCallback? onTap;
  final int userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(AbsentNotifier.provider(userName));
    double radius = 20;
    AppBar appBar = AppBar();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: appBar.preferredSize.height,
      color: VietSoftColor.appBarEmployeeBackGround,
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 16, top: 4, bottom: 4, right: 28),
              decoration: BoxDecoration(
                  color: VietSoftColor.title,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  )),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                provider.isInit
                    ? const SizedBox()
                    : InkWell(
                        onTap: () async {
                          ConfirmAction? confirmAction;
                          if (provider.isAbsent) {
                            confirmAction =
                                await CrossPlatform.showConfirmationAlert(
                              context,
                              const Text("Bạn muốn huỷ tình trạng vắng mặt?"),
                              Container(),
                              infoLabel: "Yes",
                              cancel: "No",
                            );
                          } else {
                            confirmAction =
                                await CrossPlatform.showConfirmationAlert(
                              context,
                              const Text("Bạn muốn khai báo vắng mặt?"),
                              Container(),
                              infoLabel: "Yes",
                              cancel: "No",
                            );
                          }
                          if (confirmAction != null &&
                              confirmAction == ConfirmAction.accept) {
                            ref
                                .read(
                                    AbsentNotifier.provider(userName).notifier)
                                .updateAbsent()
                                .onError((error, stackTrace) {
                              HandleError.handleUnauthorized(context, error);
                            });
                          }
                        },
                        child: Text(
                          provider.isAbsent ? "Huỷ ủy quyền" : "Ủy quyền",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                // Text(
                //     "${DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now())} $userName",
                //     style: const TextStyle(
                //       fontSize: 16,
                //       color: Colors.black,
                //     ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  // double getTitleWidth(BuildContext context) {
  //   return TextUtil.calculateTextSize(
  //     text: title,
  //     style: TextStyle(
  //         color: Colors.white, fontSize: VietSoftSize.getSize(106.53, context)),
  //   ).width;
  // }
}
