import 'package:flutter/material.dart';

//setup theme on project in here
const _inputBorderWidth = 0.5;
const _inputBorderColor = Colors.white70;
final ThemeData baseLightTheme = ThemeData.dark().copyWith(
  highlightColor: Colors.grey.shade100,
  inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      border: const OutlineInputBorder(
        borderSide:
            BorderSide(color: _inputBorderColor, width: _inputBorderWidth),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: _inputBorderColor, width: _inputBorderWidth),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.blueGrey, width: _inputBorderWidth),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: _inputBorderColor.withOpacity(0.5),
            width: _inputBorderWidth),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      hintStyle: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 61, 61, 61))),
);
