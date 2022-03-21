import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../sizeConfig/sizeConfig.dart';

// ignore: camel_case_types
class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xffFCFFFF),
    primaryColor: Color(0xffBCF2F2),
    buttonColor: Color(0xff004856),
    focusColor: Colors.black,
    accentColor: Colors.teal.shade300,
    textTheme: TextTheme(
      headline1: GoogleFonts.poppins(
        fontSize: SizeConfig.height! * 5,
        letterSpacing: 2,
        fontWeight: FontWeight.w500,
        color: Colors.teal.shade400,
      ),
      headline2: GoogleFonts.scheherazade(
        fontSize: SizeConfig.height! * 3,
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
        color: Colors.teal,
      ),
      headline3: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w600,
          height: SizeConfig.height! * 0.2,
          letterSpacing: 1.1,
          color: Colors.black),
      bodyText1: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w600,
          height: SizeConfig.height! * 0.2,
          letterSpacing: 1.1,
          color: Colors.teal.shade700),
      bodyText2: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w500,
          height: SizeConfig.height! * 0.2,
          color: Colors.black),
      subtitle1: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.1,
          height: SizeConfig.height! * 0.2,
          color: Colors.black),
      subtitle2: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.1,
          height: SizeConfig.height! * 0.2,
          color: Colors.teal.shade300),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xff003540),
    primaryColor: Color(0xff004856),
    buttonColor: Color(0xffBCF2F2),
    focusColor: Colors.white,
    accentColor: Color(0xff35A2B8),
    dialogTheme: DialogTheme(backgroundColor: Color(0xff003540)),
    textTheme: TextTheme(
      headline1: GoogleFonts.poppins(
          fontSize: SizeConfig.height! * 5,
          letterSpacing: 2,
          fontWeight: FontWeight.w500,
          color: Colors.white),
      headline2: GoogleFonts.scheherazade(
        fontSize: SizeConfig.height! * 3,
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline3: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w600,
          height: SizeConfig.height! * 0.2,
          letterSpacing: 1.1,
          color: Colors.black),
      bodyText1: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w600,
          height: SizeConfig.height! * 0.2,
          letterSpacing: 1.1,
          color: Colors.white),
      bodyText2: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w500,
          height: SizeConfig.height! * 0.2,
          color: Colors.white),
      subtitle1: TextStyle(
          fontSize: SizeConfig.height! * 2,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.1,
          height: SizeConfig.height! * 0.2,
          color: Colors.white),
      subtitle2: GoogleFonts.poppins(
        fontSize: SizeConfig.height! * 2,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.1,
        height: SizeConfig.height! * 0.2,
        color: Color(0xff35A2B8),
      ),
    ),
  );
}
