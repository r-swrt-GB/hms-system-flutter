import 'package:flutter/material.dart';

InputDecoration textboxStyle(String? labelText) {
  return InputDecoration(
    labelText: labelText,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 7.0,
      vertical: 7.0,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.0),
      borderSide: const BorderSide(
        color: Color(0xFF2E2F30),
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Color(0xFF2E2F30),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.0),
      borderSide: const BorderSide(
        color: Color(0xFF2E2F30),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3.0),
      borderSide: const BorderSide(
        color: Color(0xFF2E2F30),
      ),
    ),
    errorStyle: const TextStyle(color: Colors.red),
  );
}
