import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/size.dart';

class RequestInfo extends StatelessWidget {
  const RequestInfo(
      {super.key,
      required this.docNum,
      required this.submitName,
      required this.requestDate});
  final String docNum;
  final String submitName;
  final DateTime requestDate;
  @override
  Widget build(BuildContext context) {
    String dateString = DateFormat("dd/MM/yyyy HH:mm").format(requestDate);
    return Column(
      children: [
        Text(
          docNum,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: VietSoftColor.title,
              fontSize: VietSoftSize.getNormalText(context)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sửa lần cuối: ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: VietSoftColor.title,
                  fontSize: VietSoftSize.getNormalText(context)),
            ),
            Text(
              "$dateString $submitName",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: VietSoftColor.title,
                  fontSize: VietSoftSize.getNormalText(context)),
            )
          ],
        )
      ],
    );
  }
}
