import 'package:flutter/material.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/UI/constants/resource_string.dart';
import 'package:viet_soft/UI/constants/size.dart';

class DocFile extends StatelessWidget {
  const DocFile({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            ResString.docFile,
            style: TextStyle(
                color: VietSoftColor.title,
                fontSize: VietSoftSize.getNormalText(context)),
          ),
        ),
        InkWell(
            onTap: onTap,
            child: Image.asset(
              "assets/icon/doc_file.png",
              width: VietSoftSize.getSize(218, context),
              height: VietSoftSize.getSize(211, context),
            ))
      ],
    );
  }
}
