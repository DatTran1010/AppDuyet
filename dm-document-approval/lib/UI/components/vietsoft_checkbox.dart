import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/size.dart';

class VietSoftCheckBox extends ConsumerWidget {
  const VietSoftCheckBox({Key? key, this.isChecked = false, this.onTap})
      : super(key: key);
  final bool isChecked;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: VietSoftSize.getSize(170, context),
        height: VietSoftSize.getSize(170, context),
        decoration: BoxDecoration(
            border: Border.all(
              color: VietSoftColor.loginTextColor,
            ),
            borderRadius: BorderRadius.circular(4)),
        child: isChecked
            ? Icon(
                Icons.check_box,
                color: VietSoftColor.backgroundGreen,
                size: VietSoftSize.getSize(138, context),
              )
            : null,
      ),
    );
  }
}
