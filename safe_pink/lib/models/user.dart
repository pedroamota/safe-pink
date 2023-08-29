import 'package:flutter/material.dart';

class user extends ChangeNotifier {
  String id;
  String name;
  String senha;
  String telefone;
  String? localizacao;
  List<String>? friends;

  user({
    required this.id,
    required this.name,
    required this.senha,
    required this.telefone,
    this.localizacao,
    this.friends,
  });
}
