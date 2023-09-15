import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/components/components_style.dart';
import 'package:safe_pink/database/servicesDB.dart';
import 'package:safe_pink/models/user.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/services/notify_service.dart';

class AlertPopUp {
  show(context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final user = Provider.of<Usuario>(context, listen: false);
    final db = ServicesDB(auth: auth);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(top: 20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            title: const Text(
              'Deseja realmente acionar o alarme?',
              style: ComponentsStyle.text,
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: const Color.fromARGB(255, 239, 7, 96),
                  width: MediaQuery.of(context).size.height * .4,
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => {
                        db.sendMessage(user.friends!, user.name!),
                        NotificationService().showNotification(
                          CustomNotification(
                            id: 1,
                            title: 'ALERTA',
                            body: 'Alerta enviado a sua lista de amigos',
                          ),
                        ),
                      },
                      child: const Text(
                        'Sim',
                        style: ComponentsStyle.text,
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(255, 239, 7, 96),
                      height: MediaQuery.of(context).size.height * .07,
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Não',
                        style: ComponentsStyle.text,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  alert(context, menssage) {
    const style = TextStyle(
      color: Color.fromARGB(255, 239, 7, 96),
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    NotificationService().showNotification(
      CustomNotification(
        id: 1,
        title: '$menssage precisa de ajuda!',
        body: 'Localização',
      ),
    );
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          title: Text(
            '$menssage precisa de ajuda! Ela está na localização x',
            style: style,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
