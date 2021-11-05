import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class DefaultAppTheme {
  static const Color primaryColor = Color(0xFFFF8F3F);
  static const Color secondaryColor = Color(0xFFE94040);
  static const Color tertiaryColor = Color(0xFF46C37B);

  static const Color background = Color(0xFFFCFCFC);
  static const Color darkBackground = Color(0xFF313234);
  static const Color textColor = Color(0xFF313234);
  static const Color grayDark = Color(0xFF4F4F4F);
  static const Color grayLight = Color(0xFFCECFD2);
  static const Color grey3 = Color(0xFF8F8F8F);

  String primaryFontFamily = 'Gilroy';
  String secondaryFontFamily = 'Roboto';

  static TextStyle get title1 => TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
      fontFamily: 'Gilroy');

  static TextStyle get title2 => TextStyle(
      color: textColor,
      fontWeight: FontWeight.w600,
      fontSize: 17,
      fontFamily: 'Gilroy');

  static TextStyle get title3 => TextStyle(
      color: textColor,
      fontWeight: FontWeight.w600,
      fontSize: 13,
      fontFamily: 'Gilroy');

  static TextStyle get subtitle1 => TextStyle(
      color: grayLight,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontFamily: 'Gilroy');

  static TextStyle get subtitle2 => TextStyle(
      color: textColor,
      fontWeight: FontWeight.normal,
      fontSize: 13,
      fontFamily: 'Gilroy');

  static TextStyle get bodyText1 => TextStyle(
      color: textColor,
      fontWeight: FontWeight.w500,
      fontSize: 15,
      fontFamily: 'Gilroy');

  static TextStyle get bodyText2 => TextStyle(
      color: grayLight,
      fontWeight: FontWeight.normal,
      fontSize: 15,
      fontFamily: 'Gilroy');

  static ButtonStyle buttonDefaultStyle = ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 44),
      textStyle: DefaultAppTheme.title2.override(
        fontFamily: 'Gilroy',
        color: Colors.white,
      ),
      primary: primaryColor,
      onPrimary: Colors.white,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)));

  static ButtonStyle buttonOutlineStyle = ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 44),
      textStyle: DefaultAppTheme.title2.override(
        fontFamily: 'Gilroy',
        color: DefaultAppTheme.primaryColor,
      ),
      primary: Colors.white,
      onPrimary: DefaultAppTheme.primaryColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: DefaultAppTheme.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(100.0)));

  static ButtonStyle buttonCircular = ElevatedButton.styleFrom(
      fixedSize: Size(32, 32),
      primary: DefaultAppTheme.primaryColor,
      onPrimary: Colors.white,
      textStyle: DefaultAppTheme.subtitle2
          .override(fontFamily: 'Gilroy', color: Colors.white),
      side: BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));
}

extension TextStyleHelper on TextStyle {
  TextStyle override(
          {String? fontFamily,
          Color? color,
          double? fontSize,
          FontWeight? fontWeight,
          FontStyle? fontStyle}) =>
      TextStyle(
        fontFamily: fontFamily ?? this.fontFamily,
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
      );
}
