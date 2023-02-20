import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/size.dart';

class LoginTextField extends ConsumerWidget {
  const LoginTextField(
      {Key? key,
      required this.hintText,
      this.initialValue,
      this.onChanged,
      this.obscureText = false})
      : super(key: key);

  final String hintText;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool obscureText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
        initialValue: initialValue,
        style: TextStyle(
          color: VietSoftColor.loginTextColor,
          fontSize: VietSoftSize.getSize(79.37, context),
        ),
        obscureText: obscureText,
        onChanged: onChanged,
        cursorColor: VietSoftColor.loginTextColor,
        decoration: InputDecoration(
            labelText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: const BorderSide(
                  color: VietSoftColor.loginTextColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: const BorderSide(
                  color: VietSoftColor.loginTextColor, width: 1.5),
            )));
  }
}
