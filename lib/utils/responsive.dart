import 'package:flutter/material.dart';

class Responsive {
  static double height(BuildContext context, double heightPercentage) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double convertHeightPercentage = heightPercentage / 100;
    return mediaQueryHeight * convertHeightPercentage;
  }

  static double width(BuildContext context, double widthPercentage) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double convertWidthPercentage = widthPercentage / 100;
    return mediaQueryWidth * convertWidthPercentage;
  }

  static double getHeight(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return mediaQueryHeight;
  }

  static double getWidth(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.width;
    return mediaQueryHeight;
  }
}
