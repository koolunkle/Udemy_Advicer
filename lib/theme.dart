import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ********************
  // static color
  // ********************
  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.blue;

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _appbarColorDark = Colors.blueGrey.shade800;

  static const Color _iconColor = Colors.white;

  static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);

  // ********************
  // Text Style - light
  // ********************
  static const TextStyle _lightHeadingText = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: 'Rubik',
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static const TextStyle _lightBodyText = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: 'Rubik',
      fontStyle: FontStyle.italic,
      fontSize: 16,
      fontWeight: FontWeight.bold);

  static const TextTheme _lightTextTheme =
      TextTheme(headlineLarge: _lightHeadingText, bodyLarge: _lightBodyText);

  // ********************
  // Text Style - dark
  // ********************
  static final TextStyle _darkThemeHeadingTextStyle =
      _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyTextStyle =
      _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
      headlineLarge: _darkThemeHeadingTextStyle,
      bodyLarge: _darkThemeBodyTextStyle);

// ********************
// Theme light/dark
// ********************
  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _lightPrimaryColor,
      appBarTheme: const AppBarTheme(
          color: _appbarColorLight,
          iconTheme: IconThemeData(color: _iconColor)),
      bottomAppBarTheme: const BottomAppBarTheme(color: _appbarColorLight),
      colorScheme: ColorScheme.light(
          primary: _lightPrimaryColor,
          onPrimary: _lightOnPrimaryColor,
          secondary: _accentColor,
          primaryContainer: _lightPrimaryVariantColor),
      textTheme: _lightTextTheme);

  static final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _darkPrimaryColor,
      appBarTheme: AppBarTheme(
          color: _appbarColorDark,
          iconTheme: const IconThemeData(color: _iconColor)),
      bottomAppBarTheme: BottomAppBarTheme(color: _appbarColorDark),
      colorScheme: ColorScheme.dark(
          primary: _darkPrimaryColor,
          onPrimary: _darkOnPrimaryColor,
          secondary: _accentColor,
          primaryContainer: _darkPrimaryVariantColor),
      textTheme: _darkTextTheme);
}
