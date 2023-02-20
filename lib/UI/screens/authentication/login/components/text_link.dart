import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viet_soft/UI/constants/size.dart';

class TextLink extends ConsumerWidget {
  const TextLink(
      {Key? key,
      this.onTap,
      required this.title,
      this.italic = true,
      this.color,
      this.isBold = true})
      : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool italic;
  final Color? color;
  final bool isBold;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
            fontStyle: italic ? FontStyle.italic : null,
            decoration: TextDecoration.underline,
            fontSize: VietSoftSize.getSize(79.37, context),
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: color),
      ),
    );
  }
}
