
import 'package:flutter/material.dart';

class Styles {
  static TextStyle customTextStyle({
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    FontStyle fontStyle: FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  static TextStyle titleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    double fontSize = 24,
    FontStyle fontStyle: FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

}
