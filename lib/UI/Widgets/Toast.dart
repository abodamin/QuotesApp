import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class T {
  static void message(String msg, context) {
    Toast.show(
      msg,
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
}
