import 'package:flutter/material.dart';

class InputDecorartions {
  static InputDecoration inputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text(labelText),
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null);
  }
}
