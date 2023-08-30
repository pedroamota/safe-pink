import 'package:flutter/material.dart';

class Usuario extends ChangeNotifier {
  String? id;
  String? name;
  String? username;
  String? senha;
  String? telefone;
  String? latitude;
  String? longitude;
  List<String>? friends;
  String? help;
  bool? alert;
}
