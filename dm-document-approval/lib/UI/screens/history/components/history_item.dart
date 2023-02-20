import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/constants/size.dart';
import 'package:viet_soft/UI/screens/authentication/login/components/text_link.dart';
import 'package:viet_soft/logic/models/history.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(
      {super.key, required this.approvalHistory, this.onDocLinkTap});
  final History approvalHistory;
  final VoidCallback? onDocLinkTap;
  @override
  Widget build(BuildContext context) {
    String dateString =
        DateFormat("dd/MM/yyyy HH:mm").format(approvalHistory.date);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(bottom: VietSoftSize.getSize(151, context)),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: VietSoftColor.loginTextColor))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateString,
                style: TextStyle(
                    color: VietSoftColor.title,
                    fontWeight: FontWeight.w500,
                    fontSize: VietSoftSize.getNormalText(context)),
              ),
              if (approvalHistory.agreement == -1) ...[
                Text(
                  'Yêu cầu duyệt',
                  style: TextStyle(
                      color: VietSoftColor.loginTextColor,
                      fontSize: VietSoftSize.getNormalText(context)),
                )
              ] else if (approvalHistory.agreement == 0) ...[
                Text(
                  'Không đồng ý',
                  style: TextStyle(
                      color: VietSoftColor.emergencyColor,
                      fontSize: VietSoftSize.getNormalText(context)),
                )
              ] else if (approvalHistory.agreement == 2) ...[
                Text(
                  'Ủy quyền',
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: VietSoftSize.getNormalText(context)),
                )
              ] else ...[
                Text(
                  'Đồng ý',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: VietSoftSize.getNormalText(context)),
                )
              ],
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: VietSoftSize.getSize(194, context),
              bottom: VietSoftSize.getSize(243, context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${approvalHistory.tranferUser}:",
                  style: TextStyle(
                      color: VietSoftColor.loginTextColor,
                      fontSize: VietSoftSize.getNormalText(context)),
                ),
                Text(
                  approvalHistory.opinion.toString().trim()!,
                  style: TextStyle(
                      color: VietSoftColor.title,
                      fontSize: VietSoftSize.getNormalText(context)),
                )
              ],
            ),
          ),
          secondRow(context)
        ],
      ),
    );
  }

  Widget secondRow(BuildContext context) {
    if (approvalHistory.documentLink != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ResString.docFile,
            style: TextStyle(
                color: VietSoftColor.loginTextColor,
                fontSize: VietSoftSize.getNormalText(context)),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Image.asset(
                  "assets/icon/doc_link_icon.png",
                  width: VietSoftSize.getSize(66, context),
                  height: VietSoftSize.getSize(69, context),
                ),
              ),
              TextLink(
                onTap: onDocLinkTap,
                title: ResString.docLink,
                isBold: false,
                italic: false,
                color: VietSoftColor.title,
              ),
            ],
          )
        ],
      );
    } else {
      return Text(
        approvalHistory.agreement == 1 ? "Yes" : "No",
        style: TextStyle(
            color: VietSoftColor.title,
            fontSize: VietSoftSize.getNormalText(context)),
      );
    }
  }
}
