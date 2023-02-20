import 'package:flutter/widgets.dart';

class VietSoftSize {
  static const double degsignScreenWidth = 2000;
  static const double normalTextSize = 79.37;

  static double getSize(double value, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return value * screenWidth / degsignScreenWidth;
  }

  static double getNormalText(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return normalTextSize * screenWidth / degsignScreenWidth;
  }
}
