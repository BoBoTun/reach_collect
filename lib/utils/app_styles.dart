import 'package:flutter/material.dart';

class AppTheme {
  //Colors
  static const Color whiteColor = Color(0xffffffff);
  static const Color primaryColor = Color(0xffe1f6ff);
  static const Color secondaryColor = Color(0xff003747);
  static const Color shadowColor = Color(0x14003747);
  static const Color thirdColor = Color(0xff026A81);
  static const Color selectColor = Color(0xff5594a2);
  //Text Style
  static const TextStyle splashStyle = TextStyle(
      color: secondaryColor,
  fontSize: 60,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w500);

  static const TextStyle largeStyle = TextStyle(
      color: secondaryColor,
      fontSize: 40,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500);

  static const TextStyle navigationTitleStyle = TextStyle(
      color: whiteColor,
      fontSize: 40,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500);

  static const TextStyle buttonTextStyle = TextStyle(
      color: whiteColor,
      fontSize: 18,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500);

  static const TextStyle headerTextStyle = TextStyle(
      color: whiteColor,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400);

  static const TextStyle itemTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300);

  static const TextStyle calenderTitle = TextStyle(
      color: secondaryColor,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500);

  static const TextStyle inputStyle = TextStyle(color: Colors.black,fontSize: 16);
  static const TextStyle hintStyle = TextStyle(color: Colors.black12,fontSize: 16);


  //Images
  static const loginImg = "assets/images/login.png";
  static const importImg = "assets/images/import.png";
  static const kInsuranceLogo = 'assets/images/insurance.png';
  static const kExportLogo = 'assets/images/export.png';
  static const kPlusIcon = 'assets/images/plus.png';
  static const kBackIcon = 'assets/images/back.png';
}