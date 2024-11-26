import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColorLight = "#789cf5".fromHex;
  static Color darkGrey = "#525252".fromHex;
  static Color grey = "#737477".fromHex;
  static Color lightGrey = "#9E9E9E".fromHex;
  static Color primaryOpacity70 = "#5676c4".fromHex;


  //new colors 
  static Color darkPrimary = "#052880".fromHex;
  static Color grey1 = "#707070".fromHex;
  static Color grey2 = "#797979".fromHex;
  static Color white = "#FFFFFF".fromHex;
  static Color error = "#e61f34".fromHex; //red color

  static Color black = "#000000".fromHex; //black

    // Primary / Main color
  static Color primaryCol = "#1A2B55".fromHex;

  // Red
  static Color red = "#B81616".fromHex;

  // Shadow Color
  static Color shadowCol = "#00000040".fromHex;

  static  Color warningCol = Colors.yellow;
  static  Color errorCol= Colors.red;
  static  Color successCol = Colors.green;


  //tiles color

  static Color orangeColor = "#f7a56d".fromHex;
  static Color orangeColor2 = "#fc6803".fromHex;
  

  static Color strawBerryColor = "#f57d99".fromHex;
  static Color strawBerryColor2 = "#fa003a".fromHex;


  static Color purpleColor = "#8581d4".fromHex;
  static Color purpleColor2 = "#0c02d9".fromHex;


  static Color lightGreen = "#02D8D5".fromHex;
  static Color lightGreen2 = "#93c7c6".fromHex;


  static Color lightPurple = "#C1CFFD".fromHex;
  static Color lightPurple2 = "#829efa".fromHex;


  static Color creamColor = "#F7F1D7".fromHex;
  static Color creamColor2 = "#f7de6f".fromHex;
  static Color textFeildColor = "#E8EAF7".fromHex;
  
}

extension HexColor on String {
  Color get fromHex{
    String hexColorString = this;
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
