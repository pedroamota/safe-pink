import 'package:flutter/material.dart';

class NotifyUser {
  static show(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        backgroundColor: Colors.purple,
        content: Text(message),
      ),
    );
  }
}
