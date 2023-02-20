import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/size.dart';

class OpinonTextField extends StatelessWidget {
  const OpinonTextField(
      {super.key,
      required this.title,
      this.initialValue,
      required this.hintText,
      this.readOnly = false,
      this.onChange});
  final String title;
  final String? initialValue;
  final String hintText;
  final bool readOnly;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: VietSoftColor.title,
              fontSize: VietSoftSize.getNormalText(context)),
        ),
        Container(
          width: double.maxFinite,
          height: VietSoftSize.getSize(350, context),
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              border: Border.all(color: VietSoftColor.loginTextColor),
              borderRadius: BorderRadius.circular(4)),
          child: TextFormField(
            onChanged: onChange,
            readOnly: readOnly,
            initialValue: initialValue,
            style: TextStyle(
                color: VietSoftColor.loginTextColor,
                fontSize: VietSoftSize.getNormalText(context)),
            cursorColor: VietSoftColor.loginTextColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  color: VietSoftColor.loginTextColor,
                  fontSize: VietSoftSize.getNormalText(context)),
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ],
    );
  }
}
