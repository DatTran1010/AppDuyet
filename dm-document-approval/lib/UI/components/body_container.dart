import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/size.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer(
      {super.key, this.child, required this.topMargin, this.padding});
  final Widget? child;
  final double topMargin;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    double radius = 60;
    return Container(
        margin: EdgeInsets.only(top: VietSoftSize.getSize(topMargin, context)),
        padding: padding,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            )),
        child: child);
  }
}
