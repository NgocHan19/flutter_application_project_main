import 'package:flutter/material.dart';
class PrimaryText {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFFDCAA), Color(0xFFFFA726),],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Paint createGradientPaint(Rect rect) {
    return Paint()
      ..shader = primaryGradient.createShader(rect);
  }
  static TextStyle primaryTextStyle({double fontSize = 16, FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      foreground: Paint()
        ..shader = primaryGradient.createShader(
          Rect.fromLTWH(0, 0, 200, 70), 
        ),
    );
  }
    static const LinearGradient primaryGradient1 = LinearGradient(
    colors: [Color(0xFFFFDCAA), Color(0xFFFFA726),],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static TextStyle primaryTextStyle1({double fontSize = 16, FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      foreground: Paint()
        ..shader = primaryGradient1.createShader(
          Rect.fromLTWH(0, 0, 500, 70), 
        ),
    );
  }
  static const LinearGradient primaryGradient2 = LinearGradient(
    colors: [
      Color(0xFFFFDCAA),
      Color(0xFFFFA726),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static TextStyle primaryTextStyle2({double fontSize = 16, FontWeight fontWeight = FontWeight.bold}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      foreground: Paint()
        ..shader = primaryGradient2.createShader(
          Rect.fromLTWH(0, 0, 500, 70),
        ),
    );
  }
}