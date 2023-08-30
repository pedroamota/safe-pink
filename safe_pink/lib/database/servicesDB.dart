import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/models/user.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/view/home/alert/alert_pop_up.dart';

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

  void getData(String email, context) async {
    final user = Provider.of<Usuario>(context, listen: false);

    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('dados').doc(email).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        user.name = userData['name'];
        user.username = userData['username'];
        user.telefone = userData['phone'];
        user.friends = userData['friends'];
        user.alert = userData['alert'];
        user.help = userData['help'];
        user.latitude = userData['latitude'];
        user.longitude = userData['longitude'];
      } else {
        print('Documento do usuário não encontrado.');
      }
    } catch (e) {
      print('Erro ao obter dados do usuário: $e');
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

  void listenToAlertChanges(String userEmail, context) {
    FirebaseFirestore.instance
        .collection('dados')
        .doc(userEmail)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        bool alertStatus = userData['alert'] ?? false;
        String message = userData['help'] ?? false;
        // Aqui você pode fazer o que for necessário com o status do alerta
        if (alertStatus) {
          AlertPopUp().alert(context, message);
          // Execute as ações necessárias quando o alerta estiver ativado
        } else {
          print('Alerta desativado.');
        }
      } else {
        print('Documento do usuário não encontrado.');
      }
    });
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
