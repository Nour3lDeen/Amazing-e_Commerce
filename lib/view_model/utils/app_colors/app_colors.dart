
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color grey = Colors.grey;
  static Color red = Colors.red;
  static Color primaryColor = HexColor('#03A186');
  static Color secondaryColor = HexColor('#FFEF01');
  static Color borderColor = HexColor('#FFED00');
  static Color othersColor = HexColor('#C5E5E0');
  static Gradient gradient = LinearGradient(
    colors: [
      HexColor('#998F01'),
      HexColor('#EADB00'),],
  );
}