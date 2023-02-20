import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/size.dart';

class VietSoftDivider extends StatelessWidget {
  const VietSoftDivider({super.key, this.padding});
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: VietSoftSize.getSize(112, context), horizontal: 12),
      child: const Divider(
        height: 0,
        thickness: 1,
        color: VietSoftColor.loginTextColor,
      ),
    );
  }
}
