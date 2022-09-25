import 'package:flutter/material.dart';

InputDecoration kTextFieldDecoration = const InputDecoration(
  hintStyle: TextStyle(
    color: Color(0xFF9E9E9E),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black87, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black87, width: 2.0),
  ),
);
