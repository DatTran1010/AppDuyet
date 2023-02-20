import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/constants/size.dart';

class VietSoftBottomBar extends ConsumerWidget {
  const VietSoftBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: VietSoftColor.botBarBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            ResString.databaseName,
            style: TextStyle(color: VietSoftColor.databaseNameColor),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Image.asset(
              "assets/logo/logo_vietsoft.png",
              width: VietSoftSize.getSize(139, context),
              height: VietSoftSize.getSize(139, context),
            ),
          ),
          const Text(
            ResString.companyName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: VietSoftColor.companyNameColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
