import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/constants/size.dart';

class HistoryRequestInfo extends StatelessWidget {
  const HistoryRequestInfo({super.key, required this.docNum});
  final String docNum;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Column(
          children: [
            Text(
              ResString.approvalDoc,
              style: TextStyle(
                color: VietSoftColor.loginTextColor,
                fontSize: VietSoftSize.getNormalText(context),
              ),
            ),
            Text(
              docNum,
              style: TextStyle(
                color: VietSoftColor.title,
                fontSize: VietSoftSize.getNormalText(context),
              ),
            )
          ],
        ),
      ],
    );
  }
}
