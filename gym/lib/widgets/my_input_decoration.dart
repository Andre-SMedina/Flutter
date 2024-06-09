import 'package:flutter/material.dart';

InputDecoration myInputDecoration(String label) {
  return InputDecoration(
    // hintText: label,
    label: Text(label),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(64)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: const BorderSide(width: 2)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: const BorderSide(width: 2, color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: const BorderSide(width: 4, color: Colors.red)),
  );
}
