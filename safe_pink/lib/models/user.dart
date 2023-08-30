import 'package:flutter/material.dart';

class Usuario extends ChangeNotifier {
  String? id;
  String? name;
  String? username;
  String? senha;
  String? telefone;
  String? latitude;
  String? longitude;
  List<dynamic>? friends;
  String? help;
  bool alert = false;
}
