import 'package:flutter/material.dart';
import 'package:my_peopler/src/utils/hexColor.dart';

class Pallete {
  // Primary / Main color
  static Color primaryCol = HexColor("#1A2B55");

  // White
  static Color white = HexColor("#FFFFFF");

  // Red
  static Color red = HexColor("#B81616");

  // Shadow Color
  static Color shadowCol = HexColor("#00000040");

  static  Color warningCol = Colors.yellow;
  static  Color errorCol= Colors.red;
  static  Color successCol = Colors.green;

  static Color cardWhite = '#FFFFFF'.fromHex;

}

extension CustomHexColor on String {
  Color get fromHex{
    String hexColorString = this;
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
