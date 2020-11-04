import 'package:flutter/material.dart';

InputDecoration textDecorationConstant(String label) {
  return InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0.0),
      filled: true,
      fillColor: Colors.transparent,
      labelText: label,
      hintStyle: TextStyle(color: Colors.black38),
      labelStyle: TextStyle(
        fontFamily: "Sofia",
        color: Colors.black38,
      ));
}