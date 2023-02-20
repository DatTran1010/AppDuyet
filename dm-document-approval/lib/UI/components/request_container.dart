import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';

class RequestContainer extends StatelessWidget {
  const RequestContainer({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: VietSoftColor.loginTextColor),
          borderRadius: BorderRadius.circular(4)),
      child: child,
    );
  }
}
