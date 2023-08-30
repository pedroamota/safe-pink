import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_pink/services/auth_service.dart';

import 'DBFirestore.dart';

class ServicesDB {
  late FirebaseFirestore db;
  late AuthService auth;

  ServicesDB({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future<void> saveUser(String name, String username, String phone) async {
    try {
      final userDocRef = db.collection('dados').doc('${auth.usuario!.email}');
      await userDocRef.set({
        'name': name,
        'username': username,
        'phone': phone,
        'friends': [],
        'latitude': '',
        'longitude': '',
        'help': '',
        'alert': false,
      });
      print('User data saved successfully.');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  addFriend(newEmail) async {
    final userDocRef = db.collection('dados').doc('${auth.usuario!.email}');

    DocumentSnapshot userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      List<dynamic> currentFriends = userSnapshot.get('friends') ?? [];

      if (!currentFriends.contains(newEmail)) {
        currentFriends.add(newEmail);

        await userDocRef.update({
          'friends': currentFriends,
        });

        print('Novo amigo adicionado com sucesso!');
      } else {
        print('O email do novo amigo já está na lista.');
      }
    } else {
      print('Documento do usuário não encontrado.');
    }
  }

  sendMessage(List<String> friends) {
    friends.forEach((i) async {
      await db.collection('dados/$i').doc('mensagem').update({
        'name': auth.usuario!.email,
        'alert': true,
      });
    });
  }
}
