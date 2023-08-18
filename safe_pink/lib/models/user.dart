class user {
  String id;
  String name;
  String senha;
  String? localizacao;
  List<String>? friends;

  user({
    required this.id,
    required this.name,
    required this.senha,
    this.localizacao,
    this.friends,
  });
}
