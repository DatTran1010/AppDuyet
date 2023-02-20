import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/size.dart';

class DateField extends ConsumerWidget {
  const DateField(
      {required this.title, required this.date, this.onTap, Key? key})
      : super(key: key);
  final String title;
  final DateTime date;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String dayString = DateFormat("dd").format(date);
    String monthString = DateFormat("MM").format(date);
    String yearString = DateFormat("yyyy").format(date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(
                color: VietSoftColor.title,
                fontSize: VietSoftSize.getSize(79.37, context)),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 12),
            padding:
                const EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
            decoration: BoxDecoration(
                border: Border.all(color: VietSoftColor.loginTextColor),
                borderRadius: BorderRadius.circular(19)),
            child: Text(
              "$dayString/$monthString/$yearString",
              style: const TextStyle(color: VietSoftColor.loginTextColor),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
