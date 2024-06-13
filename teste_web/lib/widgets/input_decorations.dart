import 'package:flutter/material.dart';

InputDecoration myInputDecoration(String label) {
  return InputDecoration(
    // hintText: label,
    label: Text(
      label,
      style: const TextStyle(color: Color.fromARGB(255, 150, 150, 150)),
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(64)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: const BorderSide(width: 2, color: Colors.black)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: const BorderSide(width: 2, color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: const BorderSide(width: 4, color: Colors.red)),
  );
}
