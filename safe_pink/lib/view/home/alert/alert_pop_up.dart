import 'package:flutter/material.dart';
import 'package:safe_pink/services/notify_service.dart';

class AlertPopUp {
  show(context) {
    const style = TextStyle(
      color: Color.fromARGB(255, 239, 7, 96),
      fontWeight: FontWeight.bold,
      fontSize: 20,
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
            title: const Text(
              'Deseja realmente acionar o alarme?',
              style: style,
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
                        style: style,
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
                        style: style,
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
              '$menssage precisa de ajuda!. Ela está na localização x e y',
              style: style,
              textAlign: TextAlign.center,
            ),
          );
        },);
  }
}
