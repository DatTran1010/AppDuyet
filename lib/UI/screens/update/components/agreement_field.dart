import 'package:flutter/material.dart';
import 'package:viet_soft/UI/components/vietsoft_checkbox.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/constants/size.dart';

class AgreementField extends StatelessWidget {
  const AgreementField({super.key, required this.isChecked, this.onTap});
  final bool isChecked;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            ResString.agreement,
            style: TextStyle(
                color: VietSoftColor.title,
                fontSize: VietSoftSize.getNormalText(context)),
          ),
        ),
        VietSoftCheckBox(
          isChecked: isChecked,
          onTap: onTap,
        )
      ],
    );
  }
}
