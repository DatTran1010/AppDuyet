import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viet_soft/UI/constants/colors.dart';
import 'package:viet_soft/logic/models/request.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({super.key, required this.request, this.onTap});
  final Request request;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    String dateString = DateFormat("dd/MM/yyyy").format(request.date);
    TextStyle style = TextStyle(
        color: request.emergency!
            ? VietSoftColor.emergencyColor
            : VietSoftColor.title);
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                  border: Border.all(color: Colors.grey, width: 1.5)),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${request.documentName} ",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      Text(dateString,
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Colors.black54,
                                  ))
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: Text(
                          "Yêu cầu: ${request.docNum}",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: Colors.black54,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Người yêu cầu: ${request.submitFullName!.isNotEmpty ? request.submitFullName! : request.submitUserName!}",
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ],
              ),
            ),
          )

          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 2,
          //     child: Text(
          //       "${request.documentName} ",
          //       style: style,
          //     )),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 4,
          //     child: Text(
          //       " ${request.docNum} $dateString",
          //       style: style,
          //     )),
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 1,
          //     child: Text(
          //       request.submitFullName!.isNotEmpty
          //           ? request.submitFullName!
          //           : request.submitUserName!,
          //       style: style,
          //     ))
        ],
      ),
    );
  }
}
