import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/size.dart';

class VietSoftTextField extends StatelessWidget {
  const VietSoftTextField({Key? key, required this.hintText, this.initialValue})
      : super(key: key);

  final String hintText;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        style: TextStyle(
          color: VietSoftColor.loginTextColor,
          fontSize: VietSoftSize.getSize(79.37, context),
        ),
        cursorColor: VietSoftColor.loginTextColor,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: VietSoftColor.loginTextColor,
              fontSize: VietSoftSize.getSize(79.37, context),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: VietSoftColor.loginTextColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: VietSoftColor.loginTextColor, width: 1),
            )));
  }
}
