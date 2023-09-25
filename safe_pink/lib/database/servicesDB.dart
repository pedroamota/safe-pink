import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/models/makers.dart';
import 'package:safe_pink/models/user.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/services/notify_service.dart';
import 'package:safe_pink/services/position_service.dart';

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

  //USUARIO

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
        'msm': '',
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

  Future<void> sendMessage(
      List<dynamic> emailList, String name, String msm) async {
    try {
      CollectionReference dadosCollection =
          FirebaseFirestore.instance.collection('dados');

      for (String email in emailList) {
        DocumentReference userDocRef = dadosCollection.doc(email);
        Map<String, dynamic> updatedData = {
          'alert': true,
          'help': name,
          'msm': msm,
        };
        await userDocRef.update(updatedData);
        print('Document for $email updated successfully.');
      }

      print('All documents updated.');
    } catch (e) {
      print('Error updating documents: $e');
    }
  }

  saveLocal(double latitude, double longitude) async {
    final userDocRef = db.collection('dados').doc('${auth.usuario!.email}');

    await userDocRef.update({
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  //SEMPRE ATIVADAS

  void listenToAlertChanges(context) {
    FirebaseFirestore.instance
        .collection('dados')
        .doc(auth.usuario!.email)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        bool alertStatus = userData['alert'] ?? false;
        String message = userData['help'] ?? false;
        //TODO depois que pego o emial, dou um get para pegar a mensagem
        if (alertStatus) {
          NotificationService.alert(context, message);
          // Execute as ações necessárias quando o alerta estiver ativado
        } else {
          print('Alerta desativado.');
        }
      } else {
        print('Documento do usuário não encontrado.');
      }
    });
  }

  Future<List<dynamic>> _getEmails() async {
    try {
      // Referência ao documento do usuário
      final userDocRef = FirebaseFirestore.instance
          .collection('dados')
          .doc(auth.usuario!.email);

      // Obtendo os dados do documento
      final userDocSnapshot = await userDocRef.get();

      // Verifique se o documento existe antes de acessar a lista de amigos
      if (userDocSnapshot.exists) {
        // Obtenha a lista de amigos do documento
        List<dynamic> friends = userDocSnapshot.data()!['friends'] ?? [];
        return friends;
      } else {
        // Se o documento não existir, você pode lidar com isso de acordo com sua lógica
        throw Exception('Documento do usuário não encontrado');
      }
    } catch (e) {
      // Lidar com erros ou exceções aqui, se necessário
      print('Erro ao buscar a lista de amigos: $e');
      return [];
    }
  }

  void getLocalFriends(context) async {
    final markers = Provider.of<MarkersEntity>(context, listen: false);
    Set<Marker> listMarkers = {};
    List<dynamic> listEmails = [];

    listEmails = await _getEmails();

    for (dynamic email in listEmails) {
      final DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('dados')
          .doc(email) // Use o email como ID do documento
          .get();

      var aux = Marker(
        markerId: MarkerId(doc['name']),
        position: LatLng(
          doc['latitude'] as double,
          doc['longitude'] as double,
        ),
      );

      listMarkers.add(aux);
    }

    markers.setMarkers(listMarkers);
  }
}
