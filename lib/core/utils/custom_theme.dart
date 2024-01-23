import 'package:flutter/material.dart';
import 'package:mini_wallet/core/utils/app_colors/app_colors_light.dart';

ThemeData buildCustomDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      prefixIconColor: AppColorsLight.black,
      hintStyle: TextStyle(
        color: AppColorsLight.black,
      ),
      fillColor: Color(0xffeee5fa),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: AppColorsLight.primaryDark,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: Color(0xfff8e0e9),
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: AppColorsLight.primaryDark,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      contentPadding: EdgeInsets.only(
        top: 15.0,
        left: 15.0,
        right: 15.0,
        bottom: 15.0,
      ),
    ),
    primarySwatch: Colors.purple,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        // color: AppColorsLight.black,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        // color: AppColorsLight.black45,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          AppColorsLight.primaryDark,
        ),
        foregroundColor: MaterialStatePropertyAll(
          AppColorsLight.white,
        ),
        elevation: MaterialStatePropertyAll(
          8,
        ),
      ),
    ),
  );
}

ThemeData buildCustomLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      prefixIconColor: AppColorsLight.black,
      hintStyle: TextStyle(
        color: AppColorsLight.black,
      ),
      fillColor: Color(0xffeee5fa),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: AppColorsLight.primaryDark,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: Color(0xfff8e0e9),
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: AppColorsLight.primaryDark,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      contentPadding: EdgeInsets.only(
        top: 15.0,
        left: 15.0,
        right: 15.0,
        bottom: 15.0,
      ),
    ),
    primarySwatch: Colors.purple,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        // color: AppColorsLight.black,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        // color: AppColorsLight.black45,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          AppColorsLight.primaryDark,
        ),
        foregroundColor: MaterialStatePropertyAll(
          AppColorsLight.white,
        ),
        elevation: MaterialStatePropertyAll(
          8,
        ),
      ),
    ),
  );
}
