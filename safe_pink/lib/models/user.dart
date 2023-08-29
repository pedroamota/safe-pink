import 'package:flutter/material.dart';

class user extends ChangeNotifier {
  String id;
  String name;
  String senha;
  String telefone;
  String? latitude;
  String? longitude;
  List<String>? friends;

  user({
    required this.id,
    required this.name,
    required this.senha,
    required this.telefone,
    this.latitude,
    this.longitude,
    this.friends,
  });
}
