import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_pink/services/auth_service.dart';

import 'DBFirestore.dart';

class RegisterDB {
  late FirebaseFirestore db;
  late AuthService auth;

  RegisterDB({required this.auth}) {
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
      'latitude':'',
      'longitude':'',
      'alert': false,
    });
    print('User data saved successfully.');
  } catch (e) {
    print('Error saving user data: $e');
  }
}


  addFriend(List<String> friends) async {
    await db
        .collection('dados/${auth.usuario!.email}')
        .doc('user')
        .update({'friends': friends});
  }

  sendMessage(List<String> friends) {
    friends.forEach((i) async {
      await db.collection('dados/$i').doc('mensagem').set({
        'name': auth.usuario!.email,
        'alert': true,
      });
    });
  }
}
