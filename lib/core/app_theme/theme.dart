import 'package:flutter/material.dart';
import 'package:task_2/core/values/colors.dart';

class CustomTheme {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        primaryColor: isDarkTheme ? Colors.black : Colors.white,
        scaffoldBackgroundColor:
            isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
        backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
        indicatorColor:
            isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
        hintColor:
            isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
        highlightColor:
            isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
        hoverColor:
            isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
        focusColor:
            isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
        canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        dialogTheme: DialogTheme(
          backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
        ),
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light()),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
        ),
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: isDarkTheme ? Colors.white : Colors.black),
        iconTheme: IconThemeData(color: isDarkTheme ? darkGreen : Colors.black),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: darkGreen,
        ),
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            hintStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w100,
                color: isDarkTheme ? const Color(0xffF1F5FB) : Colors.black)));
  }
}
