import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/constants/size.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton(
      {Key? key,
      required this.buttonTitle,
      this.padding,
      required this.darkBtnColor,
      required this.lightBtColor,
      this.onTap})
      : super(key: key);
  final String buttonTitle;
  final EdgeInsets? padding;
  final Color darkBtnColor;
  final Color lightBtColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: double.maxFinite,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: darkBtnColor,
            borderRadius: BorderRadius.circular(55),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.1,
                  0.5,
                  0.9
                ],
                colors: [
                  darkBtnColor,
                  lightBtColor,
                  darkBtnColor,
                ])),
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: VietSoftSize.getSize(79.37, context)),
        ),
      ),
    );
  }
}
